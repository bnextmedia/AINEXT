---
title: "AI Coding Agent 的架構演進：從 Amp Code 看 Sub-agent 設計"
date: 2025-12-25T15:30:00+08:00
description: "Coding agent 的核心就是一個 for loop，但魔鬼藏在細節裡。Amp Code 的創辦人 Beyang Liu 深入講解他們如何用 sub-agent 架構解決 context exhaustion 問題，以及 Finder、Oracle、Librarian、Kraken 四個專用 sub-agent 的設計原理。"
tags: ["Amp Code", "AI Agent", "Sub-agent", "Context Window", "技術架構"]
categories: ["AI 產業"]
source_url: "https://www.youtube.com/watch?v=gvIAkmZUEZY"
source_name: "AI Engineer World's Fair"
draft: false
---

> 本文整理自 Beyang Liu 在 AI Engineer World's Fair 的演講。

{{< youtube gvIAkmZUEZY >}}

---

「Agent 是什麼？就是一個 for loop，加上工具呼叫，加上一個模型。」Amp Code 創辦人 Beyang Liu 在演講開頭就這樣說。這句話聽起來有點輕描淡寫——如果 agent 這麼簡單，為什麼市場上的 coding agent 表現差異這麼大？

答案藏在細節裡。當你用這個框架去思考 agent，你會發現真正可以調整的「槓桿」其實不多：模型選擇、工具設計、以及模型與工具互動的方式。但就像程式語言最終都是 if 和 for loop 的組合，你可以從這些簡單的元素中組合出驚人的複雜度。

這篇文章要深入 Amp 的架構設計，特別是他們如何用 sub-agent 解決 coding agent 最常見的問題。

## Context Exhaustion：每個 Agent 開發者都遇過的問題

如果你用過任何 coding agent 超過一週，你一定遇過這個狀況：agent 花了很多時間在讀檔案、搜尋程式碼庫、理解上下文，等到它終於要開始改程式碼時，context window 已經快滿了。要嘛它必須提前結束，要嘛它開始產出品質低落的程式碼。

這就是所謂的 context exhaustion。

最天真的解法是叫 agent 少讀一點資料——既然讀資料會佔用 context，那就少讀一點，把空間留給後面的編輯。但這會導致另一個問題：agent 沒有蒐集到足夠的上下文，於是它不知道自己在幹嘛，一直嘗試同樣的錯誤解法，陷入 Liu 所說的「doom loop」——無限迴圈地重試同樣的失敗策略。

這是一個兩難：讀太多資料會耗盡 context，讀太少資料會導致 agent 無法正確完成任務。

## Sub-agent：程式語言中 Subroutine 的類比

Amp 的解法是大量使用 sub-agent。如果你熟悉程式設計，可以把 sub-agent 想成 subroutine（子程式）。主程式呼叫一個 subroutine，subroutine 在自己的執行環境中完成工作，然後只把結果回傳給主程式。主程式不需要知道 subroutine 內部做了什麼，只需要拿到最終結果。

Sub-agent 做的事情類似。當主 agent 需要完成一個子任務（比如「在整個程式碼庫中搜尋所有使用某個 API 的地方」），它可以把這個任務交給一個 sub-agent。這個 sub-agent 有自己的 context window，可以在裡面做任何它需要做的事情——讀十個檔案、搜尋二十個 pattern、嘗試三種不同的策略——最後只把精華結果回傳給主 agent。

這樣做的好處是，主 agent 的 context 不會被 sub-agent 的中間過程塞滿。如果 sub-agent 讀了十個檔案才找到答案，主 agent 只會看到最終答案，而不是那十個檔案的完整內容。

但 Amp 團隊對 sub-agent 的應用不只是這種通用型的「context 隔離」。他們為不同的任務類型設計了專門的 sub-agent，每一個都有獨特的模型選擇、工具集、和 system prompt。

## Finder：專為程式碼搜尋設計的 Sub-agent

Finder 是 Amp 的程式碼庫搜尋 sub-agent。它的工作是在大型程式碼庫中快速找到相關的檔案和程式碼片段。

Liu 特別提到，Finder 使用的是「相對小而快的模型」搭配「精簡的工具集」。這個設計選擇反映了一個重要的洞察：搜尋任務不需要最聰明的模型，它需要的是速度和精準的工具。

這裡的「精簡工具集」是關鍵。Amp 團隊沒有給 Finder 所有可能用到的工具，而是只給它最適合搜尋任務的那幾個。這減少了模型需要考慮的選項，讓它更容易做出正確的工具選擇。

這個設計哲學也解釋了為什麼 Amp 不太依賴 MCP（Model Context Protocol）。MCP server 的開發者不知道你的 agent 在做什麼，所以他們寫的工具描述是通用的。但 Amp 可以針對 Finder 的特定需求，精心調整每一個工具的描述、參數格式、和回傳格式。

## Oracle：把 Reasoning 做成 Sub-agent

大多數 coding agent 處理「需要深度思考」的場景的方式，是讓使用者切換到一個 reasoning model（比如 o1 或 Claude 的 extended thinking）。但 Amp 的做法不同：他們把 reasoning 能力包裝成一個叫做 Oracle 的 sub-agent。

目前 Oracle 使用的是 GPT-5 with medium reasoning level。當主 agent 遇到一個棘手的問題——比如一個難以追蹤的 bug，或者一個需要仔細規劃的架構決策——它可以把問題丟給 Oracle，讓 Oracle 花時間「深度思考」。

為什麼不直接讓主 agent 用 reasoning model？Liu 的解釋是，reasoning model 比較慢、比較貴，而且不太適合日常的程式碼編輯任務。如果你讓主 agent 永遠都用 reasoning model，你會發現它在簡單任務上變得太慢、太囉嗦。

透過把 reasoning 做成 sub-agent，你可以保持主 agent 的「輕快」——它能快速回應日常任務——同時在需要的時候調用 Oracle 的能力。Liu 分享他自己的使用經驗：當遇到一個他本來要花一兩個小時 debug 的問題，他會叫 Amp 調用 Oracle。Oracle 可能要跑好幾分鐘，但大約八成的機率能直接解決問題。

Amp 的官方文件建議使用者在以下情況主動要求調用 Oracle：

- 「用 Oracle 來審核上一個 commit 的變更」
- 「問 Oracle 有沒有更好的解法」
- 「我有一個 bug，幫我修。盡量多用 Oracle，因為它比較聰明」

這些 prompt 範例顯示了一個有趣的使用模式：使用者可以明確地「調度」不同的能力層級，而不是被動地等待 agent 自己決定。

## Librarian：超越單一程式碼庫的能力

Librarian 是另一個專用 sub-agent，它的工作是從外部函式庫和框架的文件中擷取資訊。當你使用一個第三方函式庫遇到問題時，Librarian 可以去搜尋那個函式庫的 GitHub repository，找出相關的程式碼和文件。

這個能力特別重要，因為 coding agent 常見的一個失敗模式是：它對你正在使用的函式庫「一知半解」——它大概知道這個函式庫是幹嘛的，但不知道最新版本的 API 細節，或者不知道一些常見的 edge case。透過 Librarian，agent 可以主動去查閱最新的原始碼和文件，而不是依賴它訓練資料中可能已經過時的資訊。

值得注意的是，Amp 文件特別提到 Librarian 的回答「通常比較長、比較詳細」。這暗示了 Librarian 的設計目標不只是「回答問題」，而是「提供深度解釋」。當主 agent 需要理解一個複雜的外部依賴時，它需要的不是一句話的答案，而是足夠的上下文來做出正確的決策。

## Kraken：大規模重構的專門 Sub-agent

Amp 還有一個實驗性的 sub-agent 叫做 Kraken。它的工作不是一個一個檔案地編輯程式碼，而是寫 codemod（程式碼修改腳本）來處理大規模重構。

這個設計反映了一個重要的洞察：當你需要在一百個檔案中做同樣的修改時，讓 agent 一個一個檔案去改是非常低效的。每次編輯都會佔用 context、消耗 token、增加出錯的機會。更聰明的做法是寫一個腳本，一次處理所有檔案。

傳統上，寫 codemod 需要開發者理解 AST（抽象語法樹）操作，這是一個相對進階的技能。Kraken 的目標是讓這個能力變得更容易取得——你描述你想要做的修改，Kraken 來寫 codemod。

## Context Management 的其他工具

除了 sub-agent 架構，Amp 還提供了其他的 context management 工具。

**Handoff** 讓你可以把一個 thread（對話）中的相關資訊「打包」帶到新的 thread。這避免了 thread 越來越長、越來越難管理的問題。

**Thread Reference** 讓你可以在當前對話中引用另一個 thread 的內容。Amp 會用另一個模型來從被引用的 thread 中擷取相關資訊，而不是把整個 thread 的內容塞進當前的 context。

**Fork** 讓你可以在某個對話節點「分叉」，創造兩個不同的對話走向，而不需要重新開始。

這些工具都圍繞著同一個核心問題：context window 是有限且珍貴的資源，你需要精心管理什麼進去、什麼不進去。

## Sub-agent 架構的設計原則

從 Amp 的設計中，我們可以歸納出幾個 sub-agent 架構的設計原則：

**專門化而非通用化**：不要做一個「什麼都能幹」的通用 sub-agent。針對特定任務類型（搜尋、推理、外部查詢、大規模重構）設計專門的 sub-agent，每一個都有最適合該任務的模型、工具集、和 system prompt。

**Context 隔離**：Sub-agent 的主要價值之一是隔離中間過程，只回傳結果。這讓主 agent 的 context 保持乾淨。

**速度 vs 能力的權衡**：不同的任務需要不同的權衡。搜尋任務需要速度，用小模型；推理任務需要能力，用大模型。透過 sub-agent 架構，你可以在同一個系統中同時擁有這兩種能力。

**使用者可見的調度**：Amp 讓使用者可以明確地要求調用特定的 sub-agent（比如「用 Oracle 來審核」）。這給了進階使用者更多的控制權，同時也不會讓一般使用者感到困惑。

對於正在建造 coding agent 的團隊來說，這些設計原則提供了一個有價值的參考框架。Agent 的核心確實很簡單——一個 for loop 加上模型和工具——但把它做好需要對 context management、模型特性、和使用者需求有深入的理解。

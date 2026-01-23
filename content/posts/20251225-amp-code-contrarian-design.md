---
title: "Amp Code 的「反常識」設計哲學：為什麼不讓使用者選模型"
date: 2025-12-25T14:00:00+08:00
description: "Amp Code 創辦人 Beyang Liu 分享這款 coding agent 的設計決策：不做模型選擇器、不依賴 MCP、用 sub-agent 取代單一大模型。這些「反常識」選擇背後，是對開發者工作流更深層的思考。"
tags: ["Amp Code", "AI Agent", "Beyang Liu", "Coding Agent", "產品設計"]
categories: ["AI 技術前沿"]
source_url: "https://www.youtube.com/watch?v=gvIAkmZUEZY"
source_name: "AI Engineer World's Fair"
draft: false
---

> 本文整理自 Beyang Liu 在 AI Engineer World's Fair 的演講。

{{< youtube gvIAkmZUEZY >}}

---

市場上的 coding agent 已經多到讓人眼花撩亂。Cursor、Windsurf、GitHub Copilot、Claude Code——每隔幾週就有新的選手加入戰局。在這個擁擠的市場裡，Amp Code 的創辦人 Beyang Liu 選擇了一條不同的路：他不打算說服你 Amp 是「最好的」，而是要告訴你，他們的思考方式有多麼不一樣。

這種「不一樣」體現在幾個核心設計決策上，而這些決策乍看之下都有點反常識。

## 為什麼不做模型選擇器

打開任何一款主流 coding agent，你幾乎都會看到一個模型選擇器——讓你在 GPT-4、Claude、Gemini 之間切換。開發者喜歡選擇，或者至少喜歡「有選擇的感覺」。但 Amp 團隊認為，這種設計其實是一個架構陷阱。

問題在於，當你支援 N 種模型時，你的 agent 框架只能做「輕度客製化」。每個模型都有不同的特性、不同的最佳 prompt 方式、不同的工具呼叫格式。如果你試圖讓同一套框架適配所有模型，結果就是你無法針對任何一個模型做深度最佳化。這就像設計一雙「適合所有人」的鞋子——最後誰穿都不合腳。

Amp 的做法是只維護兩個頂層 agent：Smart 和 Rush。Smart agent 配備了所有進階功能——sub-agent、深度推理、大規模重構能力——適合那種「交給它去跑，回來看結果」的任務。Rush agent 則是為了快速迭代設計的，當你想緊貼在 agent 旁邊、一步步微調程式碼時使用。

這種設計反映了一個更深層的觀察：開發者使用 agent 其實只有兩種模式。一種是非同步模式——你把任務丟給 agent，然後去做別的事，等它完成後再來審核程式碼。另一種是同步模式——你就坐在那裡，看著 agent 一步步改程式碼，隨時準備介入。與其給你 20 種模型選項讓你自己去摸索，不如直接針對這兩種使用情境做最佳化。

## 自訂工具優先，MCP 其次

MCP（Model Context Protocol）是 Anthropic 推出的協定，讓各種工具可以標準化地為 AI agent 提供上下文。這個協定引發了整個生態系的熱潮，大家都在寫 MCP server。但 Amp 團隊決定把主要精力放在自訂工具上，而不是追逐 MCP 整合。

這個決定背後有兩個考量。首先是「回饋迴路」的概念。當你深入使用 coding agent，你會發現最重要的事情是幫助 agent 找到正確的回饋迴路——寫程式碼、執行測試、看到錯誤、修正、再試。要讓這個迴路順暢運轉，你需要精心設計的工具，這些工具的描述、參數、回傳格式都要針對你的 agent 行為做最佳化。

MCP server 的問題在於，它的開發者不知道你的 agent 在做什麼。他們寫的工具描述是通用的，不會針對你 agent 的特定需求做調整。結果就是，你的 agent 可能會用錯工具、用錯參數、誤解回傳結果。

第二個問題是「上下文混亂」。當你把太多工具塞進 context window，agent 就要在一大堆選項中做選擇。如果這些工具跟當前任務不太相關，agent 反而會被搞糊塗。Amp 團隊寧願維護一組精簡、高度客製化的核心工具，而不是讓使用者自己去接一堆 MCP server。

## Sub-agent 才是擴展能力的正確方式

幾乎每個使用過 coding agent 的人都遇過「context exhaustion」——agent 在找資料、讀程式碼的過程中用掉了大部分 context window，等到要開始改程式碼時已經沒剩多少空間了。天真的解法是叫 agent 少讀一點資料，但這會導致另一個問題：agent 沒搜集到足夠的上下文，於是一直嘗試同樣的錯誤解法，陷入「doom loop」。

Amp 的解法是大量使用 sub-agent。這就像程式語言裡的 subroutine——你把一個子任務交給 sub-agent，它在自己的 context window 裡做完所有事情，最後只把精華結果回傳給主 agent。這樣主 agent 的 context 就不會被中間過程塞滿。

但 Amp 的 sub-agent 不是那種「稍微改一下 system prompt、稍微調整一下工具」的通用型 sub-agent。他們為不同任務設計了專門的 sub-agent：Finder 用小而快的模型搭配精簡工具集來搜尋程式碼庫；Oracle 是專門的推理 sub-agent，當主 agent 卡住時可以呼叫它來「深度思考」；Librarian 負責從外部函式庫和框架文件中擷取資訊；Kraken 則專門寫 codemod 來處理大規模重構。

這種設計的好處是，你可以保持主 agent 的「輕快」——它能快速回應、流暢使用各種工具——同時在需要的時候調用專門的能力。比如說，當遇到一個很難 debug 的問題，與其讓主 agent 一直轉圈圈，不如把問題丟給 Oracle 讓它花幾分鐘認真想一想。Liu 說他大概有八成的機率靠 Oracle 解決那些他本來要花一兩個小時才能搞定的問題。

## 對產品設計者的啟示

Amp 團隊的這些決策，反映了一種特定的產品哲學：寧願做「有觀點的」（opinionated）產品，也不要做「什麼都可以」的萬用工具。他們明確表示，Amp 不是為所有人設計的——他們瞄準的是那一小群「想活在未來一年」的開發者。

這種取捨在 AI 產品設計中特別重要。因為 AI 的能力還在快速變化，沒有人真正知道最佳實踐是什麼。在這種情況下，你可以選擇給使用者最大彈性，讓他們自己去探索；或者你可以根據自己的判斷做出選擇，然後把這個選擇做到極致。Amp 選擇了後者。

這不代表他們一定是對的，但至少這是一個清楚的賭注。

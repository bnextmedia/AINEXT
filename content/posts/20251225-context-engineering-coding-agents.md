---
title: "Context Engineering 實戰指南——為什麼你的 AI 編程工具總是寫出爛 Code"
date: 2025-12-25T10:00:00+08:00
description: "AI 編程工具的問題不在模型，在於 context window 管理。HumanLayer 創辦人 Dex Horthy 提出「Dumb Zone」理論，解釋為什麼超過 40% context 使用率後效果急劇下降，並分享 Research-Plan-Implement 三階段工作流。"
tags: ["Context Engineering", "AI 編程", "Claude Code", "Dex Horthy", "HumanLayer"]
categories: ["AI 產業"]
source_url: "https://www.youtube.com/watch?v=rmvDxxNubIg"
source_name: "AI Engineer World's Fair 2025"
draft: false
---

> 本文整理自 AI Engineer World's Fair 2025 的演講「No Vibes Allowed: Solving Hard Problems in Complex Codebases」。
> 🎧 收聽連結：[YouTube](https://www.youtube.com/watch?v=rmvDxxNubIg)

「我第一次用 Claude Code 的時候，並沒有很驚艷。」

這句話出自 Dex Horthy，一個靠 AI Agent 吃飯的人。他的公司 HumanLayer 專門做 AI Agent 的人機協作，他在六月的 AI Engineer 大會上講的「12 Factor Agents」是當屆最熱門的演講之一。這樣一個人，第一次用 Claude Code 卻沒什麼感覺。

但八週後，他的三人團隊徹底改變了工作方式，生產力提升了兩到三倍，而且——這是關鍵——產出的程式碼品質沒有下降。不是那種「寫得很快但之後要花更多時間修」的假性提升，是真的又快又好。

他們發現了什麼？

## 問題不在模型，在你怎麼餵它

DORA 的調查很殘酷：他們訪問了十萬名開發者，發現大多數人用 AI 寫程式的結果是——大量的 rework。你這週用 Cursor 寫的 code，下週有很大一部分時間在修上週的爛 code。整體來看，你確實 commit 更多了，但很多都是在清理之前製造的技術債。

更慘的是，這個問題在「棕地」（brownfield）專案中特別嚴重。如果你是從零開始做一個 Vercel dashboard 小專案，AI 表現得很好。但如果你要進一個十年歷史的 Java 程式碼庫改東西？祝你好運。

Dex 說，這完全符合他跟很多創辦人和資深工程師聊天的經驗。大家的反應都是：「AI 編程？對我們的 codebase 不管用。也許等模型更好的時候吧。」

但問題真的在模型嗎？

不。問題在 context。

## 歡迎來到 Dumb Zone

LLM 有一個常被忽略的特性：它是 stateless 的。每一次它決定下一步要做什麼，唯一的依據就是當前 context window 裡的內容。沒有記憶，沒有累積，就只有眼前這一堆 tokens。

所以，如果你想讓 LLM 的輸出變好，唯一的方法就是讓輸入變好。Better tokens in, better tokens out。

這聽起來是廢話，但它導出了一個非常實際的問題：context window 是有限的。以 Claude Code 為例，你大約有 168,000 個 tokens 可以用。聽起來很多，但 Dex 提出了一個觀察：當你用掉大約 40% 的 context window 之後，模型的表現會開始明顯下滑。

他把這個區間叫做「Dumb Zone」。

這個 40% 的門檻不是絕對的，會因任務複雜度而異。但概念很清楚：context window 不是「用得越多越好」，而是「用得越多越笨」。如果你裝了一堆 MCP 外掛，每次對話都往 context 裡塞一堆 JSON 和 UUID，那你基本上整個工作流程都在 Dumb Zone 裡面，永遠拿不到好結果。

Geoff Huntley 的研究也支持這一點：context window 用得越滿，結果越差。

## 最慘的不是資訊太多，是資訊錯誤

如果要把 context window 的問題排個優先級，Dex 說最糟糕的情況依序是：

1. **錯誤的資訊**——讓模型以為某個函式在 A 檔案，但其實在 B 檔案
2. **缺少的資訊**——模型不知道某個關鍵的限制條件
3. **太多雜訊**——塞了一堆不相關的東西進去

還有一個容易被忽略的因素：對話的「軌跡」。很多人的使用模式是這樣的：叫 AI 做一件事，做錯了，罵它一頓，叫它重做，又做錯了，又罵它一頓。

問題是，LLM 會從這個對話軌跡中學到什麼？它學到的是：「在這個對話裡，我做錯事，人類就會罵我，然後我再做錯事，人類再罵我。」所以下一個最可能的 token 是什麼？當然是繼續做錯事讓人類繼續罵。

這就是為什麼當你看到 Claude 回覆「I apologize for the confusion」的時候，通常代表這個對話已經沒救了，你應該開一個新的 context window 重來。

## Intentional Compaction：聰明地管理 Context

既然 context window 這麼珍貴，解法就是「壓縮」。Dex 把這個做法叫做 Intentional Compaction。

概念很簡單：不管你的對話進行到什麼階段，你都可以請 AI 把當前的 context 壓縮成一份 Markdown 檔案，記錄到目前為止學到了什麼、找到了哪些相關檔案、下一步要做什麼。然後你檢視這份檔案，開一個新的對話，把這份壓縮過的 context 餵給它，讓它直接開始工作，而不是重新做一遍搜尋和理解程式碼的過程。

一份好的 compaction 會包含：正在解決的問題是什麼、相關的檔案路徑和行號、目前的理解和下一步計畫。

這樣做的好處是，新的 context window 一開始就在「Smart Zone」裡，不會被之前的搜尋過程、錯誤的嘗試、冗長的 build output 給塞滿。

## Sub-agents 不是用來扮演角色的

很多人用 sub-agents 的方式是這樣：設一個「前端 agent」、一個「後端 agent」、一個「QA agent」、一個「資料科學家 agent」。

Dex 說：拜託別這樣做。

Sub-agents 的真正用途是控制 context，不是擬人化。正確的用法是：當你需要在一個大型程式碼庫裡找某個功能是怎麼運作的，你可以 fork 出一個子對話，讓它去做所有的搜尋、讀檔、理解程式碼的工作，然後只回傳一個精簡的結論：「你要的東西在這個檔案的這一行。」

主 agent 收到這個精簡的回覆，讀那一個檔案就可以開始工作，不需要把整個搜尋過程的 tokens 都帶在身上。

這就是用 sub-agents 來「聰明地避開 Dumb Zone」。

## Research → Plan → Implement

Dex 的團隊發展出一套三階段的工作流程，他們把它叫做 RPI（Research, Plan, Implement）。雖然他自己說不太喜歡這個縮寫，但社群已經開始這樣叫了，他也沒辦法。

**Research 階段**：搞清楚系統怎麼運作。找到相關的檔案，理解程式碼的流程，保持客觀。這個階段的產出是一份研究文件，壓縮了「真實的程式碼是怎麼運作的」這個知識。

**Plan 階段**：根據研究結果，列出具體的執行步驟。包含檔案名稱、行號、要修改的程式碼片段，以及每一步之後要怎麼測試。這個階段的產出是一份計畫文件，壓縮了「我們要做什麼」這個意圖。

**Implement 階段**：執行計畫。如果 Plan 寫得夠好，這個階段幾乎是機械性的，即使是「最笨的模型」也不太會搞砸。

關鍵在於，每個階段結束後都要做 compaction。Research 做完，壓縮成研究文件，開新對話；Plan 做完，壓縮成計畫文件，開新對話。這樣每個階段都在 Smart Zone 裡工作。

## 一行 Research 錯，整個專案毀

這個工作流程有一個重要的含義：你的注意力應該放在哪裡？

Dex 這樣說：一行爛 code 就是一行爛 code。但計畫文件裡一行錯誤的描述，可能導致一百行爛 code。而研究文件裡一個對系統的錯誤理解，可能讓整個專案走偏。

所以，高槓桿的地方是 Research 和 Plan，不是 Implement。

這也意味著：你必須讀那些文件。這不是什麼神奇的 prompt 可以自動搞定的事情，沒有什麼 silver bullet。如果你不讀 Plan，不驗證 Research 的正確性，那這套流程就沒有意義。

Jake（他們團隊的另一個人）寫過一篇文章說得很好：Research-Plan-Implement 之所以有價值，是因為有「你」這個人類在迴路中，確保每一步都是對的。

## Mental Alignment：Code Review 的真正目的

這帶出另一個重點：code review 的目的是什麼？

表面上是找 bug、確保程式碼品質。但更深層的目的是 mental alignment——讓團隊所有人對「程式碼庫正在怎麼變化」保持一致的理解。

問題是，當你用 AI 把產出速度提升兩三倍，code review 的負擔也變成兩三倍。Dex 說他一週可以讀一千行 Golang，但他不想。

這就是 Plan 文件的另一個價值：你可以透過讀 Plan 來保持 mental alignment，而不是讀每一行 code。當然程式碼還是要有人 review，但作為技術領導者，讀 Plan 就足以讓你掌握專案的走向，並且在早期就抓到潛在的問題。

Mitchell Hashimoto（HashiCorp 創辦人）也開始在 PR 裡附上他跟 AI 的對話紀錄，讓 reviewer 可以看到「他下了什麼 prompt、AI 走了什麼步驟、最後跑了什麼測試」。這比一大坨綠色的 diff 更容易理解。

## 這不是 Spec-Driven Development

有人會問：「這不就是 spec-driven development 嗎？」

Dex 說：不是。或者說，「spec-driven development」這個詞已經壞掉了。

Martin Fowler 在 2006 年就講過「語意擴散」（semantic diffusion）這個概念：一個好的術語被提出來，大家都很興奮，然後每個人開始用它來指稱不同的東西，最後這個詞就失去了意義。

「Agent」這個詞就是這樣。它曾經指人類代理人、微服務、聊天機器人、工作流程⋯⋯現在 Simon Willison 把它拉回最簡單的定義：「工具加迴圈」。

「Spec-driven development」正在經歷同樣的過程。有人說 spec 是更詳細的 prompt，有人說是 PRD，有人說是可驗證的回饋迴圈，有人說是把程式碼當 assembly 只管理 markdown，有人說只是「寫程式的時候旁邊放一堆 markdown 檔案」，甚至有人說 spec 就是開源函式庫的文件。

所以 Dex 不用這個詞。他用的是 context engineering——如何管理 context window 讓 AI 發揮最大效果。如果非要一個更 hype 的詞，他說可以叫「harness engineering」，指的是如何利用 Claude、Codex、Cursor 這些工具的整合點來客製化你的開發流程。

## 挑一個工具，累積經驗

演講的最後，Dex 給了一個很實際的建議：挑一個工具，累積經驗。

不要在 Claude Code、Codex、Cursor 之間來回跳，試圖 min-max 每個工具的優缺點。那樣你什麼都學不好。

「你怎麼知道這個任務需要多少 context engineering？」答案是：你不知道，要靠經驗。你會判斷錯，有時候做太多，有時候做太少。這沒關係，重點是累積 reps。

他也預測，coding agent 本身會逐漸商品化，大家都會學會怎麼用。真正的挑戰是：你的團隊和工作流程怎麼適應一個「99% 的程式碼由 AI 產生」的世界？

現在已經出現一個裂痕：資深工程師不太用 AI，因為對他們來說提升不大；中初階工程師大量使用，因為可以填補技能缺口。結果是資深工程師每週都在清理上週 Cursor 產生的爛 code，然後他們就越來越討厭 AI。

這不是 AI 的錯，也不是中初階工程師的錯。這是文化問題，需要從上層推動改變。

如果你是公司的技術領導者，現在就開始吧：挑一個工具，累積經驗，然後把你學到的東西帶給整個團隊。

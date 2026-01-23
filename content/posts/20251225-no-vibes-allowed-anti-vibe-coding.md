---
title: "「AI 不能取代思考」——一位 Agent 專家的反 Vibe Coding 宣言"
date: 2025-12-25T11:00:00+08:00
description: "Vibe Coding 在真實專案中行不通。HumanLayer 創辦人 Dex Horthy 在 AI Engineer 大會直言：AI 只能放大你的思考，不能取代思考。當資深工程師每週都在清理 AI 產生的爛 code，問題不在 AI，在於我們怎麼用它。"
tags: ["Vibe Coding", "AI 編程", "Dex Horthy", "HumanLayer", "技術債"]
categories: ["AI 開發實戰"]
source_url: "https://www.youtube.com/watch?v=rmvDxxNubIg"
source_name: "AI Engineer World's Fair 2025"
draft: false
---

{{< youtube rmvDxxNubIg >}}

---

> 本文整理自 AI Engineer World's Fair 2025 的演講「No Vibes Allowed: Solving Hard Problems in Complex Codebases」。

演講標題就很嗆：No Vibes Allowed。

在一個「Vibe Coding」變成流行語的年代，一個專門做 AI Agent 的創業者站上台說：「不准憑感覺。」這需要一點勇氣。

Dex Horthy 是 HumanLayer 的創辦人，這家公司專門做 AI Agent 的人機協作。他今年六月在 AI Engineer 大會上講的「12 Factor Agents」是當屆最熱門的演講之一，據說還順便創造了「context engineering」這個詞。

這樣一個靠 AI Agent 吃飯的人，上台講的第一件事是：大多數人用 AI 寫程式的結果很爛。

## Tech Debt Factory 的現實

DORA 做了一個十萬人的調查，結論很殘酷：用 AI 寫程式，你確實 commit 更多了，但很大一部分時間是在清理上週製造的爛 code。

Dex 說這完全符合他的觀察。他跟很多創辦人和資深工程師聊過，大家的反應都差不多：「AI 編程？太多 slop（爛貨）了。技術債製造工廠。對我們的 codebase 不管用。」

問題在哪？不是模型不夠聰明。問題在於 Vibe Coding——隨便問一問、AI 寫錯了就罵它、罵完再問、問到你放棄或崩潰為止。

這個模式在做小專案的時候還行。你從零開始做一個 Vercel dashboard，AI 表現得很好。但如果你要進一個十年歷史的 Java 程式碼庫改東西？那就是另一回事了。

Dex 用一個很學術的詞來形容這個現象：「Dumb Zone」。

## 你越罵它，它越笨

Context window 是 LLM 的工作記憶。以 Claude Code 為例，大概有 168,000 個 tokens。聽起來很多，但當你用掉大約 40% 之後，模型的表現就開始明顯下滑。Dex 把這個區間叫做 Dumb Zone。

這個 40% 不是絕對的數字，會因任務複雜度而異。但概念很清楚：context window 不是用得越多越好。塞越滿，模型越笨。

更慘的是對話「軌跡」的影響。典型的 Vibe Coding 是這樣的：

1. 你叫 AI 做一件事
2. 它做錯了
3. 你罵它一頓，叫它重做
4. 它又做錯了
5. 你又罵它一頓
6. 重複直到你放棄

問題是，LLM 會從這個對話軌跡中學到什麼？它學到的是：「在這個對話裡，我做錯事，人類就罵我，然後我再做錯事，人類再罵我。」

所以下一個最可能的 token 是什麼？當然是繼續做錯事。

這就是為什麼當你看到 Claude 回覆「I apologize for the confusion」的時候，通常代表這個對話沒救了。正確的做法是開一個新的 context window 重來，而不是繼續在爛掉的對話裡罵它。

## 不要外包思考

Dex 講了一個很重要的原則：AI cannot replace thinking. It can only amplify the thinking you have done, or the lack of thinking you have done.

AI 不能取代思考。它只能放大你做過的思考——或者放大你沒做的思考。

如果你花了時間理解問題、想清楚解法、規劃好步驟，AI 會幫你加速執行。但如果你沒想清楚就直接丟給 AI，它會用十倍的速度幫你把專案帶進溝裡。

這就是為什麼他的演講叫「No Vibes Allowed」。不是說 AI 不好用，而是說你不能「憑感覺」用它。你需要一個結構化的流程。

他們團隊用的流程叫 Research-Plan-Implement：

**Research**：先搞清楚系統怎麼運作。找到相關的檔案，理解程式碼的流程。產出是一份研究文件。

**Plan**：根據研究結果，列出具體的執行步驟。包含檔案名稱、行號、要修改的程式碼片段。產出是一份計畫文件。

**Implement**：執行計畫。如果前兩步做得好，這步幾乎是機械性的。

關鍵是：你必須讀那些文件。Research 文件裡一個錯誤的理解，可能讓整個專案走偏。Plan 文件裡一行錯誤的描述，可能導致一百行爛 code。

這不是什麼神奇的 prompt 可以自動搞定的事情。沒有 silver bullet。如果你不願意花時間驗證 AI 的產出，那 AI 編程對你來說永遠都會是「技術債製造工廠」。

## 資深工程師為什麼討厭 AI？

Dex 觀察到一個有趣的現象：現在的團隊裡出現一個裂痕。

資深工程師不太用 AI 編程工具，因為對他們來說提升不大。他們已經會寫 code 了，AI 頂多幫忙省一點時間，但帶來的問題可能比省下的時間還多。

中初階工程師大量使用 AI，因為可以填補技能缺口。他們用 Cursor 寫了很多 code，其中有些是 slop。

結果是：資深工程師每週都在清理上週 Cursor 產生的爛 code，然後他們就越來越討厭 AI。

Dex 說這不是 AI 的錯，也不是中初階工程師的錯。這是文化問題。

如果你的團隊沒有建立一套用 AI 的規範，沒有 code review 的流程去抓 AI 產生的問題，沒有讓資深工程師參與定義「怎麼用 AI 才是對的」，那這個裂痕只會越來越大。

而文化改變必須從上層推動。

## Code Review 的真正目的

這帶出另一個重點：code review 到底是幹嘛的？

表面上是找 bug、確保程式碼品質。但更深層的目的是 Dex 所謂的「mental alignment」——讓團隊所有人對「程式碼庫正在怎麼變化」保持一致的理解。

當你用 AI 把產出速度提升兩三倍，code review 的負擔也變成兩三倍。沒有人有時間讀那麼多 code。

他們的解法是：讓 Plan 文件成為 code review 的一部分。技術領導者可以透過讀 Plan 來保持 mental alignment，在早期就抓到潛在問題，而不是等 code 都寫完了才發現方向錯了。

Mitchell Hashimoto 也開始在 PR 裡附上他跟 AI 的對話紀錄，讓 reviewer 可以看到整個思考過程，不只是最終的 diff。

這比一大坨綠色的程式碼更容易理解，也更容易抓到問題。

## 挑一個工具，累積經驗

演講最後，Dex 給了一個很實際的建議：挑一個工具，累積經驗。

不要在 Claude Code、Codex、Cursor 之間來回跳。那樣你什麼都學不好。

「你怎麼知道這個任務需要多少前置準備？」答案是：你不知道，要靠經驗。你會判斷錯，有時候準備太多，有時候準備太少。這沒關係，重點是累積經驗。

他預測 coding agent 本身會逐漸商品化，大家都會學會怎麼用。真正的挑戰是：你的團隊和工作流程怎麼適應一個「99% 的程式碼由 AI 產生」的世界？

這需要的不是更好的 prompt，是更好的流程、更好的規範、更好的文化。

No vibes allowed。

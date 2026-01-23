---
title: "從 Spec-Driven Dev 到 Context Engineering——AI 編程方法論的語意漂移"
date: 2025-12-25T12:00:00+08:00
description: "「Spec-Driven Development」這個詞已經壞掉了。HumanLayer 創辦人 Dex Horthy 引用 Martin Fowler 的「語意擴散」理論，解釋為什麼流行術語會失去意義，以及真正有效的 AI 編程方法是什麼。"
tags: ["Spec-Driven Development", "Semantic Diffusion", "Context Engineering", "Dex Horthy", "Martin Fowler"]
categories: ["AI 產業動態"]
source_url: "https://www.youtube.com/watch?v=rmvDxxNubIg"
source_name: "AI Engineer World's Fair 2025"
draft: false
---

{{< youtube rmvDxxNubIg >}}

---

> 本文整理自 AI Engineer World's Fair 2025 的演講「No Vibes Allowed: Solving Hard Problems in Complex Codebases」。

有人問 Dex Horthy：「你講的這套不就是 Spec-Driven Development 嗎？」

他的回答很直接：「不是。Spec-Driven Development 壞掉了。」

不是這個概念壞掉了，是這個詞壞掉了。

## Semantic Diffusion：一個 2006 年的老問題

Dex 在演講中放了一張照片，問台下有沒有人認得。沒幾個人舉手——那是 Martin Fowler，軟體工程界的教父級人物之一。

Fowler 在 2006 年提出一個概念叫「Semantic Diffusion」（語意擴散）。他的觀察是這樣的：

1. 有人提出一個好術語，有清楚的定義
2. 大家都很興奮，開始使用這個詞
3. 每個人開始用它來指稱稍微不同的東西
4. 最後這個詞對一百個人有一百種意思
5. 詞彙失去意義，變得沒用

「Agent」這個詞就是典型的例子。它曾經指：
- 人類代理人
- 微服務
- 聊天機器人
- 自動化工作流程
- 帶有工具的 LLM

這個詞被用到爛掉了，以至於 Simon Willison 必須出來重新定義：「Agent 就是工具加迴圈。」回到最簡單的定義，因為其他所有的引申義都已經讓這個詞失去溝通功能。

Dex 說，這就是為什麼「永遠不會有 Agent 元年」。不是因為技術做不到，而是因為這個詞已經被語意擴散到沒有人知道它到底指什麼了。

## Spec-Driven Development 的一百種意思

同樣的事情正在發生在「Spec-Driven Development」身上。

Dex 說他本來在演講的開頭放了 Sean Wang 的那張著名 slide——「忘掉程式碼，它現在就像 assembly，你只要管 Markdown 就好。」很酷的想法，但他發現這讓聽眾把注意力放在錯的地方。

因為「Spec-Driven Dev」對不同人有完全不同的意思：

**對有些人來說**，spec 就是「更詳細的 prompt」。你本來只寫「幫我做一個登入頁面」，現在你寫一整頁的需求描述。這叫 spec-driven。

**對另一些人來說**，spec 是正式的產品需求文件（PRD）。你有產品經理寫的規格書，你把它餵給 AI。

**對技術派來說**，spec-driven 意味著可驗證的回饋迴圈——你有測試案例，AI 寫 code，跑測試，失敗就重來，直到測試通過。

**對 Sean Wang 來說**，spec-driven 是把程式碼當 assembly，你只管理高層級的 markdown 規格文件，AI 負責實作細節。

**對大多數人來說**，spec-driven 只是「寫程式的時候旁邊放一堆 markdown 檔案」。

Dex 說他上週還看到有人用「spec」來指「開源函式庫的文件」。

這個詞已經擴散到沒有意義了。

## 四件真正有效的事

既然流行術語沒用，Dex 決定講四件「實際上 work」的事情。不是什麼 hype-y 的方法論，就是他們團隊和使用者實測有效的做法。

### 1. 即時研究，壓縮真相

第一件事是「研究」。在開始寫任何 code 之前，先搞清楚系統怎麼運作。

這不是說你要預先維護一份龐大的「codebase 文件」——那種東西一定會過時，過時的文件比沒有文件更糟。Dex 放了一張圖表，問觀眾 Y 軸是什麼：「在程式碼庫的不同層級裡，你能找到多少謊言？」答案是：文件 > 註解 > 函式名稱 > 實際程式碼。越抽象的層級，謊言越多。

他們的做法是「on-demand compressed context」——按需產生壓縮過的 context。當你要做一個功能，你給 AI 一點方向指引（「我們要動的是這塊」），然後讓它派 sub-agents 去讀相關的程式碼，最後產出一份研究文件。

這份文件是對「現在的程式碼實際上怎麼運作」的快照。不是過時的文件，是從真實程式碼壓縮出來的真相。

### 2. 計畫是意圖的壓縮

第二件事是「計畫」。拿著研究結果，列出具體的執行步驟：改哪些檔案、改哪幾行、改成什麼、每改一步怎麼測試。

計畫文件越詳細，執行的可靠度越高。他們的計畫會包含實際的程式碼片段——不是模糊的描述，而是具體的 before/after。

但這裡有個取捨：計畫越詳細，可靠度越高，但可讀性越低。你得花時間讀。所以要找一個甜蜜點，對你的團隊和你的 codebase 而言。

### 3. Mental Alignment

第三件事是「心智對齊」。Code review 的真正目的不只是找 bug，是讓團隊所有人對「程式碼庫正在怎麼變化」保持一致的理解。

當你用 AI 把產出速度提升兩三倍，你不可能還用同樣的方式做 code review。Dex 說他一週「可以」讀一千行 Golang，但他「不想」。

他們的解法是讓 Plan 文件成為 review 的一部分。技術領導者讀 Plan 就能保持對專案的掌握，不需要讀每一行 code。Mitchell Hashimoto 也開始在 PR 裡附上 AI 對話紀錄，讓 reviewer 能看到整個思考過程。

### 4. 不要外包思考

第四件事，也是最重要的：不要外包思考。

AI 不能取代思考，它只能放大思考。如果你想清楚了問題和解法，AI 幫你加速執行。如果你沒想清楚，AI 幫你用十倍速度把專案搞砸。

這就是為什麼 Research 和 Plan 這兩個步驟這麼重要——它們強迫你在 AI 開始寫 code 之前就先想清楚。而且你必須讀那些文件，驗證它們是對的。

沒有完美的 prompt。沒有 silver bullet。你要做的事情沒有變少，只是變成不同的事情。

## 如果你一定要一個 Hype-y 的詞

Dex 說，如果你真的很需要一個流行詞來講這件事，可以用「Context Engineering」或「Harness Engineering」。

Context Engineering 是管理 context window 的藝術——讓 AI 在有限的工作記憶裡拿到正確的資訊，做出正確的決定。

Harness Engineering 是如何利用 Claude、Codex、Cursor 這些工具的整合點（hooks、slash commands、.claude 檔案等）來客製化你的開發流程。

但他自己說，他不是很喜歡縮寫和流行語。他們團隊的方法已經被社群叫做「RPI」（Research-Plan-Implement），他說他沒辦法阻止這件事，但也提醒：這不是什麼神奇的框架，重點是背後的原則——管理 context，壓縮資訊，不要外包思考。

## 這件事會被商品化

演講最後，Dex 做了一個預測：coding agent 本身會逐漸商品化。怎麼用這些工具、怎麼寫好的 prompt、怎麼管理 context，這些技能會變成基本功，大家都會。

真正的挑戰是：你的團隊和工作流程怎麼適應一個「99% 的程式碼由 AI 產生」的世界？

這需要的不是一個新的流行術語，是實際的文化改變。而文化改變很難，需要從上層推動。

所以如果你是技術領導者，別追流行語了。挑一個工具，累積經驗，搞清楚什麼對你的團隊有效，然後推廣下去。

這比學會最新的術語重要一百倍。

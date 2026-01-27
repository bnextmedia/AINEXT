---
title: "一個人抵一個團隊：Peter Steinberger 的 AI 開發工作流，從哲學到實戰"
date: 2026-01-27T12:00:00+08:00
description: "Clawdbot 作者 Peter Steinberger 在 live coding 中展示如何在 45 分鐘內從零建出一個完整功能，並在部落格中公開他的完整開發方法論。從 Codex 與 Claude Code 的取捨、多 agent 並行、自建 CLI 取代 MCP，到先做 CLI 再做 UI 的開發策略——這是一份來自頂尖實踐者的 AI 開發實戰指南。"
tags: ["Peter Steinberger", "Codex", "Claude Code", "AI Agent", "vibe coding", "開發工作流"]
categories: ["AI 開發實戰"]
source_url: "https://www.youtube.com/watch?v=68BS5GCRcBo"
source_name: "Elite AI-Assisted Coding"
draft: false
---

> 本文整理自兩個來源：Peter Steinberger 在 Elite AI-Assisted Coding 社群的 [live coding session](https://www.youtube.com/watch?v=68BS5GCRcBo)，以及他的部落格文章 [Shipping at Inference Speed](https://steipete.me/posts/2025/shipping-at-inference-speed)。

{{< youtube 68BS5GCRcBo >}}

---

## 不是教你寫程式，是教你怎麼跟 AI 一起工作

Peter Steinberger（@steipete）是 PSPDFKit 的創辦人，也是近期爆紅開源專案 Clawdbot 的作者。他目前同時經手三到八個專案，幾乎全靠 AI coding agent 完成開發。他在部落格裡這樣描述自己現在的狀態：產出軟體的速度，基本上就等於 AI 推論的速度。

這不是一個初學者的興奮分享，而是一個寫了十三年原生 iOS App 的資深工程師，在徹底擁抱 AI 輔助開發之後，整理出來的方法論。他的經驗值得認真看，因為他踩過的坑夠多、試過的工具夠廣、而且最重要的是——他真的在出貨，不是在寫教學文。

## 工具選擇：為什麼他從 Claude Code 轉向 Codex

Peter 在 live session 一開場就拋出了一個讓很多人意外的選擇：他最近幾乎完全從 Claude Code 轉向了 OpenAI 的 Codex CLI。

原因不是 Claude 不好。他說 Claude Code 有很多好用的功能，搜尋能力特別強（用的是 Brave API），而且在需要大量迭代修復測試的場景下表現很好。但 Codex 有一個關鍵優勢讓他無法忽視：它會花很長的時間先讀你的程式碼，然後才動手。

在 live session 中，他一邊等 Codex 工作一邊解釋：「你看，它到現在還沒開始寫任何東西，一直在讀檔案。如果是 Claude，這時候早就衝出去亂改一通了。」他在部落格中進一步說明，GPT 5 的重大突破在於它的後訓練（post-training）讓它學會了「安靜地讀十到十五分鐘的檔案」再動手。這種耐心，在大型重構任務中的差異特別明顯。

不過他也強調：跑分數據（benchmark）完全不可信，實際上手試才知道。而且他沒有完全放棄 Claude Code，在某些場景下——特別是需要網路搜尋、或是修復大量測試的長迴圈任務——Claude Code 的自動 compaction 和持續導引能力仍然更好。

他的結論是：沒有一個工具是萬能的，重點是理解每個工具的長處，針對任務選擇。

## 核心哲學：Context 管理比什麼都重要

如果要從 Peter 的整套工作流中抽出一個最核心的原則，那就是：**一切都是 context 管理的問題。**

他在 live session 中幾乎每隔幾分鐘就會提到 context。不用 MCP？因為會把 context 搞亂。不用 Playwright 做瀏覽器測試？因為會把 context 吃光。不把計劃和執行分成兩個 session？因為重新載入檔案會浪費 context。

他的邏輯很直白：AI 模型的 context window 就那麼大，你塞進去的每一個 token 都是有成本的。如果你把 context 浪費在 HTML 標籤、冗長的 MCP 工具描述、或是 Playwright 的截圖上，留給模型真正理解和撰寫程式碼的空間就少了。

在部落格中，他公開了自己的 Codex 設定：context window 上限約 273K tokens，但他把自動 compaction 的觸發點設在 233K，刻意留出空間讓模型在複雜任務中能跨越多次 compaction 繼續工作。他也提到 Claude Code 號稱支援百萬 token 的 Sonnet，但實際使用下來，模型在遠低於百萬的位置就開始變笨——那個數字比較像行銷話術。

具體的 context 管理手段包括：

**不用 MCP，改用自建 CLI。** 他幫自己常用的服務各寫了一個 CLI 工具。例如他的日誌服務 BetterStack 沒有 MCP 也沒有 CLI，他就花了兩小時讓 AI 幫他寫了一個叫 `bslog` 的命令列工具。他另外還做了一個叫 `xl` 的 curl 包裝工具，處理 Twitter API 的認證和請求。這些 CLI 只需要在 CLAUDE.md 檔案裡寫一兩行說明，模型第一次用的時候會失敗、讀到 help 訊息、然後就學會了。用他的話來說：「你用一個 loop（大約 15 秒）換來一個更乾淨的 context。」

**用 Firecrawl 取代原始 HTML。** 當模型需要讀網頁文件時，他用 Firecrawl MCP（這是他唯一使用的 MCP）把 HTML 轉成 Markdown 再送進 context。因為 HTML 標籤本身就是一大堆沒營養的 token。

**不在 context 裡寫 spec，用程式碼註解代替。** 他不會另外維護一份功能規格文件。如果某個功能邏輯複雜，他會叫模型直接在程式碼裡寫註解。這樣下次其他 agent 來讀這段程式碼時，連脈絡都一起讀到了，不需要額外載入文件。

## 直接在 main 開發：違反常識但有效

Peter 在 live session 裡輕描淡寫地丟出了一個炸彈：他直接在 main branch 上開發，不用 feature branch，不開 pull request。

他說他試過 work tree 的做法，但結果是更慢了。他遇到了一個 work tree 特有的痛點：當你在分支 A 改了某個東西，然後在分支 B 也需要那個改動時，把修改搬過去的成本比你想像的高。加上 Claude Code 有時候會跑錯目錄、跑到別的 work tree 裡去，整體的摩擦力大到不值得。

他的替代方案是：在同一個 main branch 上同時跑兩到六個 agent，各自處理不同的功能。只要你挑的任務涉及不同的檔案，agent 之間的衝突其實很少。模型在寫入檔案前會先讀一次，如果發現檔案被改過就會重讀，所以即使偶爾碰到也能自動恢復。

關鍵的配套措施是 git commit 的紀律。他在 CLAUDE.md 裡明確要求模型：不要用 `git add .`，只 add 你實際修改的檔案。這樣即使多個 agent 同時在改 main branch 上的不同東西，每次 commit 的內容仍然是乾淨、獨立的。

他在部落格中補充了另一個原則：不要 revert，寧可往新的方向 pivot。因為在 AI 開發的節奏下，重做一個功能的成本已經低到不值得花時間去 debug 一個走偏的版本。

## 先做 CLI，再做 UI

這是他在部落格中特別強調的一個策略，他稱之為「start with CLI first」原則。

他舉了一個具體的例子：他想做一個 YouTube 摘要工具。他沒有一開始就去做精美的網頁介面，而是先把核心邏輯做成一個命令列工具，讓它能正確地抓影片、產生摘要。等 CLI 版本穩定了，再讓 AI 幫他把它包成瀏覽器擴充功能。整個過程只花了一週。

背後的道理是：CLI 的介面極簡，模型不需要處理 CSS、排版、互動狀態等額外複雜度，可以把所有注意力放在核心邏輯上。等核心邏輯驗證完畢，再加上 UI 層，這時候模型已經「理解」了整個功能的運作方式，做 UI 只是錦上添花。

他在 live session 中也用了類似的手法：先讓 Codex 把 Arena 功能的後端邏輯、資料庫 migration、API endpoint 全部建好，最後才處理前端畫面。結果前端一開始確實跑不起來（少了認證、沒套用既有的 layout），但核心邏輯已經是對的了，修前端只需要幾個 prompt。

## 多 Agent 並行：無聊是最大的敵人

Peter 在 live session 裡有一段很真實的自白：兩個 agent 都在跑，但他已經無聊了。

這反映了他的日常工作模式。他的桌面通常開著好幾個終端機視窗，每個跑一個 agent。他的主螢幕放開發中的網站和主要的 agent 對話，另一個螢幕再開更多 agent。他在部落格中提到，他甚至有兩台 Mac——MacBook Pro 接大螢幕用來做主要開發，Mac Studio 透過 Jump Desktop 遠端操作，用來跑瀏覽器自動化和背景任務。兩台之間用 Tailscale 連線，他可以直接下指令：「到我的 Mac Studio 上去更新某某東西。」

他說最高效的狀態是：永遠有至少一個 agent 在跑，你在等待的時間裡去檢視另一個 agent 的產出、點擊測試、或是給第三個 agent 新的任務。等你忙完回頭看，第一個 agent 的結果已經出來了。

用他的原話來說，這種在 main branch 上的混亂式開發，是他找到的最快工作方式。

## Oracle：讓 Agent 自己去做深度研究

部落格中還提到一個特別的工具叫 Oracle。這是 Peter 自己寫的 CLI，它的作用是讓正在工作的 agent 呼叫 GPT-5 Pro 去做深度的網路研究——一次搜尋超過 50 個網站。

這解決了一個 AI 開發中常見的死結：agent 在工作到一半時遇到不懂的問題，以前它只能寫一份 Markdown 摘要丟給你，讓你自己去查。有了 Oracle，agent 可以直接「問另一個更強的 AI」，拿到答案之後繼續工作，整個迴圈不需要人類介入。

不過隨著 GPT 5.2 本身能力的提升，他現在使用 Oracle 的頻率已經從一天好幾次降到一週幾次。模型自己就能解決大部分問題了。

## 45 分鐘蓋一個功能：Live Session 全紀錄

在 live session 中，Peter 現場示範了他的工作流。他要做的功能叫「Arena」——讓使用者選擇兩到四個 Twitter 帳號，AI 抓取每個人的推文，分析他們的性格特質、思維方式、興趣領域，然後計算彼此的「相容度分數」，最後用表格呈現結果。

他的做法是這樣的：

**第一步**：開一個新的 Codex session，用語音（透過 WhisperFlow）口述整個功能需求，包括使用者介面、後端邏輯、資料庫快取結構，一口氣講完。他沒有事先寫任何規格文件。

**第二步**：Codex 花了大約十分鐘讀取現有的程式碼庫，然後開始動手。在這段等待時間裡，Peter 一邊跟觀眾聊天，一邊回答問題。

**第三步**：第一個 agent 完成了基本的架構（資料庫 migration、API endpoint、前端元件），Peter 點擊測試，發現自動完成（autocomplete）不能用。他立刻開了第二個 agent 來修這個問題，同時第一個 agent 繼續做其他東西。

**第四步**：前端畫面出來了，但沒有套用既有的頁面 layout，而且開啟時遇到認證錯誤。他直接對 agent 說：「你建了這個功能但沒有用我其他頁面的 layout，請用 Insight 頁面的 layout。而且這個功能只有登入後才能用，修好它。」

**第五步**：修好之後，他選了自己和主持人 Eleanor 的帳號，按下分析。背景任務開始跑，但因為他正在連線到 production 環境而不是 dev 環境，所以資料庫 migration 還沒跑。他請另一個 agent 處理 dev 資料庫的 migration。

**第六步**：分析完成，出現了結果：兩人在 AI 優先、開源、務實等價值觀上高度一致，相容度分數 89 分。他笑著說不知道滿分是不是 100，因為他忘了在 prompt 裡指定。

**第七步**：他叫 agent 寫測試、commit，然後繼續疊加功能——加上快取結果的顯示表格、hover 預覽、點擊跳轉等等。

整個過程不到一小時，一個包含前後端、資料庫、AI 分析、即時串流的完整功能就從零搭建完成了。雖然還有一些小問題需要收尾（即時更新還沒接好、部分 UI 細節需要調整），但核心功能已經完全可以運作。

## 語音輸入：被低估的生產力工具

Peter 在 live session 中全程使用 WhisperFlow 語音輸入來跟 agent 對話。他提到了一個特別有意思的功能：WhisperFlow 不只是語音轉文字，它還會做語意解析。

如果你說「實作功能 A，噢，其實我是說功能 B」，WhisperFlow 會直接輸出「實作功能 B」，幫你過濾掉口誤和猶豫。這不只省了打字的時間，還省了 token——因為送進模型的文字更精簡、更準確。

他說整個 vibe coding 的精髓就是：用最少的 token 傳達最準確的意圖。語音輸入加上語意修正，是他找到的最有效率的輸入方式。

在部落格中，他更進一步說自己的 prompt 越來越短，有時候就是一張截圖加上兩個字「fix padding」。模型已經夠聰明了，你不需要寫一大段 Markdown 來解釋你要什麼。

## 我的觀察

看完 Peter 的 live session 和部落格，我最大的感受是：他的整套工作流背後有一個統一的思維模型，那就是「把人類從迴圈中移除，但不是移除人類的判斷」。

他不寫測試驅動開發（TDD），因為讓 AI 先做功能、再寫測試的效率更高。他不用 feature branch，因為切換的成本大於偶爾的衝突。他不用 MCP，因為 CLI 工具加上 help 訊息就能讓模型自己學會。他不寫詳細的規格文件，因為直接用語音口述功能需求，模型就能理解。每一個省掉的步驟，都是為了減少人類等待和人類操作的時間。

但他省掉的都是「流程」，沒有省掉「判斷」。他會仔細選擇哪些功能要先做、用什麼語言做（TypeScript 做 Web、Go 做 CLI、Swift 做原生 App）。他會看 agent 的產出品質，決定要不要介入修正。他對 context 管理的深度理解，本身就是一種高層次的工程判斷。

這對我來說是一個很重要的觀察：AI 時代最有價值的技能，可能不是寫程式的能力，而是「知道什麼可以交給 AI、什麼要自己握在手裡」的判斷力。Peter 之所以能一個人抵一個團隊，不是因為他的 AI 工具比別人更好，而是因為他有十三年的工程經驗告訴他什麼該做、什麼不該做。

另一個值得深思的點是他對 context 管理的執著。表面上看，他在做各種「省 token」的技術優化——不用 MCP、用 Markdown 取代 HTML、用 CLI 取代完整的 API client。但更深層來看，他其實是在做資訊架構的設計。他在決定哪些資訊值得進入 AI 的「意識」、哪些是雜訊。這跟好的產品經理在決定功能優先級、好的編輯在決定文章要放什麼不放什麼，本質上是一樣的事情。只是在 AI 時代，這種能力有了新的應用場景，而且變得更加關鍵。

最後，他反覆提到的一句話讓我印象深刻：很多人在用 AI 寫程式的時候過度工程化了（over-engineering）。他們花大量時間設定完美的工具鏈、寫詳細的 prompt template、建複雜的自動化流程——但最有效的做法往往就是直接跟模型說話，告訴它你要什麼，然後看它做出來的東西，不行就改，改完就上。這種簡單粗暴但極度務實的態度，或許才是在 AI 開發時代最需要的心態。

你不需要完美的流程，你需要的是足夠好的判斷力，加上願意動手的勇氣。就像他的 session 標題說的：You Can Just Do Things。

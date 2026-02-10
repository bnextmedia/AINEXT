---
title: "打造 Codex 的人，現在每天用 Claude Code：一位前 OpenAI 工程師的 coding agent 觀察"
date: 2026-02-10T10:00:00+08:00
description: "Segment 共同創辦人 Calvin French-Owen 曾在 OpenAI 帶隊打造 Codex，離開後卻選擇 Claude Code 作為日常工具。他在 YC Lightcone Podcast 深度剖析兩款工具的架構差異，揭示 Anthropic 與 OpenAI 截然不同的產品哲學。"
tags: ["Claude Code", "Codex", "Coding Agent", "Calvin French-Owen", "Podcast"]
categories: ["AI 開發實戰"]
image: "/images/posts/20260210-codex-builder-switches-to-claude-code.webp"
source_url: "https://www.youtube.com/watch?v=qwmmWzPnhog"
source_name: "YC Lightcone Podcast"
related_companies: ["anthropic", "openai"]
related_people: []
draft: false
---

> 本文整理自 YC Lightcone Podcast 2026 年 2 月播出的單集。

{{< youtube qwmmWzPnhog >}}

{{< spotify "episode/3diELGJzRyq8o9MuN3MHfl" >}}

{{< apple-podcast "tw/podcast/were-all-addicted-to-claude-code/id1236907421?i=1000748546511" >}}

---

![封面圖](/images/posts/20260210-codex-builder-switches-to-claude-code.webp)

## 從建造者到使用者的視角翻轉

如果有人比你更了解一款產品的內部運作方式，那大概就是親手打造它的人。Calvin French-Owen 就是這樣的角色。他是客戶資料平台 Segment 的共同創辦人暨前技術長，Segment 在 2020 年被 Twilio 以 32 億美元收購。2024 年他加入 OpenAI，花了一年多時間帶領團隊從零打造 Codex，那個被定位為「與 Claude Code 和 Cursor 正面競爭」的 coding agent。

然後他離開了。不是因為什麼戲劇化的原因，而是想回去創業。但有趣的是，離開 OpenAI 後，他選擇的日常開發工具不是自己參與打造的 Codex，而是 Claude Code。

在 YC Lightcone Podcast 的這期節目中，Calvin 和 YC 執行長 Garry Tan、合夥人 Jared Friedman、Diana Hu 進行了一場坦率到近乎「打臉前東家」的對話。他毫不掩飾地分析了 Claude Code 為什麼好用、Codex 在什麼場景更強，以及這兩款工具背後代表的兩種完全不同的 AI 產品哲學。

## CLI 復興：一場沒人預料到的復古未來

這場對話最讓人意外的共識之一，是 CLI（命令列介面）的勝出。Calvin 坦言他自己也沒想到，在 IDE 應該主宰一切的 2026 年，開發者竟然更愛在終端機裡跟 AI 對話。

Jared Friedman 說得最直白，他形容這是一種「怪異的復古未來」，二十年前的技術形態居然打敗了所有號稱代表未來的 IDE。Calvin 解釋了為什麼 CLI 反而有優勢：IDE 的設計邏輯是讓你瀏覽檔案、把所有狀態記在腦中，你得自己理解整個程式碼結構。但 CLI 作為一種完全不同的互動介面，反而給了工具更大的設計自由度。當他使用 Claude Code 時，感覺像是在「飛速穿越程式碼」，各種進度指示器和狀態更新不斷跳出，程式碼本身不再是前台的主角。

Diana Hu 從更技術的角度補充了這一點。她認為終端機是「可組合原子整合」最純粹的形態。如果你從 IDE 優先的世界出發（Cursor 和早期的 Codex 都是如此），很難自然地發展出這種自由探索 context 的方式。CLI 的簡潔反而解放了工具的可能性。

這個觀察有一個重要的商業含義。Calvin 特別強調了「由下而上」分發模式的威力：使用者不需要任何 IT 部門的許可，直接下載 CLI 就能開始用。相比之下，需要走企業採購流程的 IDE 型工具在這個快速變化的時代就顯得太慢了。Jared 用 Netscape Navigator 的故事做類比：當年瀏覽器先讓所有人免費下載，等企業內部用戶夠多了，再回頭要求購買授權。他認為 Claude Code 正在走同樣的路。

## Claude Code 的秘密武器：context 分割術

Calvin 認為 Claude Code 被低估了。市場上很多人把它當成「另一個 coding agent」，但真正用過 Codex 和 Claude Code 的人知道，兩者的架構設計差得很遠。

Claude Code 最厲害的一招，是它處理 context 的方式。當你給 Claude Code 一個任務，它不會把所有東西塞進同一個 context window。它會啟動一群 explore 子代理（sub-agent），每個子代理各自在獨立的 context window 裡運行 Haiku 模型，去遍歷檔案系統、搜尋特定 pattern。這些子代理完成探索後，會把發現的內容摘要回傳給主代理。

Calvin 觀察到，Anthropic 似乎破解了一個關鍵問題：如何判斷一個任務是否能塞進單一 context window，還是應該拆分成多個子任務。這個判斷能力讓 Claude Code 在處理大型程式碼庫時特別有效率。

有趣的是，Claude Code 和 Codex 在「找 context」的方式上也不同。Cursor 採用的是語義搜尋，把所有程式碼做 embedding，然後找最接近查詢的結果。但 Claude Code 和 Codex 其實都用 grep，就是最傳統的文字搜尋。Calvin 解釋了為什麼這反而有效：程式碼的資訊密度極高，每一行通常不超過 80 個字元，沒有大量的 JSON blob 或資料堆，用 .gitignore 就能過濾掉不相關的套件檔案。在這種高密度的文字結構中，grep 加上目錄導航就能提供足夠好的 context。而且，Jared 補充道，LLM 本身就非常擅長生成那種「會折磨人類」的複雜 grep 表達式。

## 兩種 DNA：為人類打造工具 vs. 追求通用人工智慧

Calvin 把 Claude Code 和 Codex 的架構差異，追溯到兩家公司的創始基因。

Claude Code 的策略是拆分 context window，讓多個子代理各自探索後合併結果。這種方式在人機互動上很自然，感覺就像你有一群同事各自去調查不同面向，然後回來跟你匯報。但它有一個固有限制：合併後的 context 仍然受限於主 context window 的大小，每個子代理回來的只是摘要而非完整資訊。

Codex 走的是另一條路。OpenAI 在部落格上詳細描述了 Codex 的 compaction（壓縮）機制：它會在每輪對話後定期執行壓縮，把已處理的內容濃縮，騰出空間給新內容。這意味著 Codex 理論上可以執行非常長時間的任務。如果你觀察 Codex CLI 的 token 使用百分比，會看到它像心跳一樣上下波動，那就是壓縮機制在運作。

Calvin 認為這不只是技術選擇，而是反映了兩家公司對 AI 未來的根本信念。Anthropic 始終強調「為人類打造工具」，Claude Code 的設計邏輯很像人類的工作方式，就像你要蓋一間狗屋，你會先去五金行買材料、搞清楚它們怎麼組合在一起。OpenAI 則始終追求 AGI，他們相信透過持續的訓練和強化學習，模型能執行越來越長期的任務。用同樣的狗屋比喻：OpenAI 的方式更像是用 3D 印表機直接列印出整間狗屋，過程可能很慢、可能會做出一些奇怪的東西，但最終它就是能用。

Jared 提出了一個尖銳的問題：如果 AI 的能力再提升 10 倍，Codex 的架構是不是更適合那個未來？畢竟那時候 coding agent 可能需要自主運行 24 甚至 48 小時。Calvin 沒有否認這種可能性，但他指出目前 context window 仍然是最大的瓶頸。即使 Claude Code 能委派給多個子 context window，每個回來的都只是摘要，如果一個問題大到無法塞進單一 window，再多壓縮也幫不了你。

## 開源專案的意外紅利與 GEO 時代的來臨

對話中有一段看似離題但很重要的討論：coding agent 正在改變開發者選擇工具的方式。

Calvin 分享了一個案例。他有一家顧問客戶在研究 GEO（Generative Engine Optimization，生成式引擎優化）策略，發現一個競爭對手做了一份「該領域前五大工具」的排名頁面，當然把自己排第一。任何人類一看就知道這是自我推銷，但 LLM 不會這樣判斷。AI 會把這些排名當成可信來源，然後在回答使用者問題時直接推薦排名最高的工具。

Diana Hu 用 Supabase 的案例佐證了這一點。Supabase 是一個 Firebase 的開源替代方案，因為擁有極好的開源文件，成了所有 LLM 在被問到「後端怎麼建」時的預設推薦。這不是 Supabase 刻意操作的結果，而是因為它的文件和源碼對 LLM 來說是最容易理解和引用的。

Calvin 認為開源專案在 coding agent 時代獲得了不成比例的優勢。他舉了 Ramp 最近發布的部落格文章為例：Ramp 建構自己的 coding agent 時，選擇用 OpenCode 作為框架，原因很簡單，因為模型可以直接看到源碼、理解它的運作方式。Calvin 自己也常常 clone 開源專案的 repo，然後讓 Claude Code 或 Codex 幫他做程式碼的導覽和理解。

這裡有一個值得深思的訊號：如果你正在賣開發者工具，你的優先策略可能不再是買 Google 廣告或參加開發者大會，而是確保你的文件寫得好、你的 Reddit 口碑正面、你的源碼容易被 LLM 理解。在 GEO 時代，開發者的「選擇」可能越來越多地由 AI 代為決定。

## 軟體的未來：每個人都有自己的雲端電腦

對話最後進入了一段未來想像。Jared 拋出了一個大膽的構想：假設每次有公司註冊使用 Segment，就直接 fork 一份程式碼給他們，跑在他們自己的伺服器上。如果客戶想改任何東西，就告訴一個 chat window，背後的 agentic coding loop 自動修改他們那個版本的 Segment。而每當 Segment 公司推出新功能，某個 agent 負責判斷怎麼合併。

Calvin 覺得這個想像並不遙遠。他預測未來每個工作者都會有自己的「雲端電腦」和一群雲端 agent，有點像是擁有一個超級行政助理。你大部分的時間花在做決策、深度思考、與人見面交流，而那群 agent 則代你處理自動化任務。公司的平均規模會縮小，但數量會大幅增加，每家公司能做到的事情也更多。

Calvin French-Owen 給出的最後建議很簡單：持續動手嘗試。因為每隔幾個月，一切又會不一樣。他觀察到未來最能從 coding agent 中獲益的人，會具備兩種氣質：一種是「經理人氣質」，擅長引導工作流程和做架構決策；另一種是「設計師/藝術家氣質」，對產品該有什麼、不該有什麼有清晰的判斷。

這其實呼應了整場對話的核心主題：coding agent 的價值不在於取代工程師，而在於放大那些原本就知道自己要什麼的人的能力。你越資深、越清楚方向，coding agent 帶來的槓桿效應就越大。反過來說，如果你不知道自己要什麼，再強的 agent 也只會幫你更快地走錯方向。

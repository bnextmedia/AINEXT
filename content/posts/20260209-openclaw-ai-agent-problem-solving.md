---
title: "當 AI 自己學會解決問題：OpenClaw 告訴我們 Coding Model 的能力被嚴重低估了"
date: 2026-02-09T12:00:00+08:00
description: "OpenClaw 創造者 Peter Steinberger 發現一件事：coding model 的創造性問題解決能力，遠超出寫程式的範疇。他的 AI agent 能在 9 秒內自主處理一個從未被教過的語音辨識任務，這揭示了 AI 能力的一個被忽略的面向。"
tags: ["OpenClaw", "AI Agent", "Coding Model", "Claude Code", "Podcast"]
categories: ["AI 開發實戰"]
image: "/images/posts/20260209-openclaw-80-percent-apps-disappear.webp"
source_url: "https://www.youtube.com/watch?v=4uzGDAoNOZc"
source_name: "Y Combinator Startup Podcast"
related_companies: ["openai", "anthropic"]
draft: false
---

> 本文整理自 Y Combinator Startup Podcast 2026 年 2 月播出的單集。

{{< youtube 4uzGDAoNOZc >}}

{{< spotify "episode/17l2biWoWbUhJnun9suDU8" >}}

{{< apple-podcast "tw/podcast/openclaw-and-the-future-of-personal-ai-agents/id1236907421?i=1000748675694" >}}

---

![封面圖](/images/posts/20260209-openclaw-80-percent-apps-disappear.webp)

## 九秒，解決一個沒人教過的問題

Peter Steinberger 在摩洛哥馬拉喀什的街上走著，隨手對 WhatsApp 發了一段語音訊息給他的 AI agent。發完之後他突然愣住了：等等，我根本沒做語音辨識功能。但十秒後，agent 回覆了。

他問它怎麼做到的。答案是一串令人咋舌的即興操作：收到一個沒有副檔名的檔案，檢查檔頭發現是 Opus 音訊格式，用 ffmpeg 轉成 wav，想用 Whisper 做語音辨識但發現本機沒裝，於是在電腦裡找到一組 OpenAI API key，直接用 Curl 呼叫 OpenAI 的語音辨識 API，拿到文字，回覆。全程九秒。

更厲害的是它沒選的那條路。它可以下載本機版的 Whisper 模型，但那要花好幾分鐘。它判斷 Steinberger 是個沒耐心的人（確實是），所以選了最快的方案。這不是「執行預設流程」，這是「理解情境然後做出最佳判斷」。

Steinberger 是 OpenClaw 的創造者，也是觸及近 10 億用戶的 PDF 工具公司 PSPDFKit 的創辦人。OpenClaw 這個開源個人 AI agent 在兩週內拿下超過 17 萬顆 GitHub 星星。但讓他真正被震撼到的不是 star 數字，而是這個語音辨識的瞬間。它揭示了一個多數人還沒意識到的事實：coding model 的能力，遠遠不只是寫程式。

## 寫程式其實是在做創造性問題解決

Steinberger 在訪談中提出了一個很有洞察力的觀察：coding model 之所以能處理語音辨識這種「非程式設計」的任務，是因為寫程式的本質就是創造性問題解決。而創造性問題解決是一種抽象能力，它可以映射到現實世界的幾乎任何任務上。

想想看一個工程師在寫程式時做的事：面對一個需求，分析現有資源，評估多種可能的解法，權衡取捨（速度、可靠性、複雜度），然後選擇最適合當下情境的方案。OpenClaw 處理語音訊息時做的事一模一樣：面對一個未知格式的檔案，掃描可用工具（ffmpeg、Whisper、OpenAI API），評估每條路徑的成本（本機 Whisper 太慢、API 呼叫最快），然後執行。

這個觀察的意義在於，我們過去可能一直在低估 coding model 的通用能力。業界的注意力集中在「推理」和「知識」這些維度上，但 coding model 在訓練過程中學到的那種「拆解問題 → 搜尋資源 → 組合方案 → 執行驗證」的能力迴路，其實是一種非常強大的通用智能。它不只能寫程式，它能做任何可以被分解為「輸入 → 處理 → 輸出」的任務。

## 本機運行：能力上限的根本差異

要理解這種能力為什麼在 OpenClaw 上特別突顯，需要理解一個架構層面的差異。ChatGPT、Claude 這些服務跑在雲端，它們能做的事被嚴格限制在一個沙盒裡。你可以跟它們對話、請它們分析文字、產生內容，但它們碰不到你的檔案系統，也執行不了你電腦上的程式。

OpenClaw 跑在你自己的電腦上。這意味著它擁有和你一樣的系統權限。它能讀寫檔案、執行 shell 指令、安裝軟體、呼叫 API、操作瀏覽器。Steinberger 用一個很精準的表述概括了這個差異：機器能做任何你能用機器做的事。

這不是一個微小的差距。雲端 AI 就像一個被關在隔音室裡的天才，你只能透過一個小窗口跟它傳紙條。本機 AI 則像是一個直接坐在你電腦前的助手，它能看到你的螢幕、操作你的鍵盤、瀏覽你的檔案。同樣的「大腦」，給它完全不同的「四肢」和「感官」，產出的結果天差地別。

那個語音辨識的故事之所以成立，正是因為 agent 能直接存取本機的 ffmpeg、能掃描磁碟上的 API key、能用 Curl 發出 HTTP 請求。如果同樣的 AI 跑在雲端，它連知道你電腦上裝了什麼軟體的能力都沒有。

## 不用 MCP，用 CLI：給 AI 人類的工具

OpenClaw 在技術社群引發討論的另一個點，是它完全跳過了 MCP（Model Context Protocol）。MCP 是 Anthropic 推出的一套標準，讓 AI 模型能夠呼叫外部工具和服務。它在 AI 開發者圈幾乎成了標配，Claude Code 和 Codex 都內建了 MCP 支援。

但 Steinberger 沒有在 OpenClaw 裡做 MCP。他做了一個叫 Magporter 的工具，可以把任何 MCP 轉換成標準的 CLI 命令列工具。他的邏輯很直接：AI 已經非常擅長使用 Unix 命令了，為什麼要發明一套全新的協定來做同樣的事？

這個選擇帶來了幾個實際的好處。首先，CLI 工具可以即時載入，不需要重啟整個 agent 系統。Steinberger 指出，在 Codex 或 Claude Code 裡加入新的 MCP 工具，你得重啟整個程式。但 CLI 隨叫隨到。其次，CLI 的數量幾乎是無限的，而 MCP 工具的數量受限於有人專門為它開發適配器。最後，CLI 本來就是人類開發者習慣使用的工具，不需要為 AI 另外發明輪子。

Steinberger 在訪談中說了一句讓人印象深刻的話：沒有正常人會手動呼叫 MCP，人類就是用 CLI。他的意思是，如果一個工具人類自己都不想用，為什麼要為 AI 專門做一個？直接給 AI 人類已經在用的工具，它一樣能用得很好。

這個設計哲學其實反映了一個更深層的思考。很多 AI 工具開發者的心態是「我們需要為 AI 打造專屬的工具和協定」，但 Steinberger 的做法是「直接把人類的工具給 AI，它自己會想辦法」。而馬拉喀什的語音辨識故事正好證明了這一點：你不需要為 AI 預想每一個使用場景，你只需要給它足夠的工具和權限，它會自己找到解法。

## 十個 Codex 並行：一個人的軍團

Steinberger 的日常開發方式本身就是一場實驗。當多數開發者使用 Claude Code 時，他選擇用 OpenAI 的 Codex。他說 Codex 在動手之前會先掃過更多檔案，不需要花太多力氣去引導它的注意力。但 Codex 有一個明顯的缺點：很慢。

他的解決方案很暴力：同時開十個 Codex 實例。六個放在主螢幕上，兩個放在左邊的螢幕，兩個放在右邊。每個實例處理不同的任務，他在它們之間來回切換，檢查進度、給指示、合併結果。這種工作方式的心智負擔極高，所以他在其他所有地方都追求極致的簡化。

比如他不用 git worktree。Worktree 是 git 的進階功能，讓你在同一個 repo 裡同時 checkout 多個分支。很多使用 AI coding 工具的開發者都推薦用它來管理並行開發。但 Steinberger 覺得太複雜了。他直接複製多份 repo，每一份都留在 main branch 上。不用想分支怎麼命名、不用擔心 worktree 的種種限制、不用處理分支衝突。在他的腦中，main 永遠是可以出貨的狀態。

他甚至說自己大部分時候不看 code。code 就在終端機裡飛過去，他看的是結果，不是過程。只有碰到棘手的 bug 才會停下來仔細檢視。這聽起來很瘋狂，但他一月份推了超過 6,600 次 commit，而 OpenClaw 的功能完整度和穩定度在開源社群裡是有目共睹的。

## Agent 時代的開發者該學什麼

Steinberger 的故事帶出了一個值得所有開發者深思的問題：當 AI 能自己寫 code、自己解決問題、自己做創造性的技術決策時，開發者的價值在哪裡？

從 OpenClaw 的案例來看，答案可能是「品味」和「判斷力」。Steinberger 沒有寫 OpenClaw 的每一行程式碼，但他決定了它應該是什麼樣子：跑在本機而非雲端、像朋友而非工具、用 CLI 而非 MCP、有靈魂而非只有功能。這些都是設計決策，不是技術問題。AI 能寫出很好的 code 來實現任何一個方案，但它不會自己決定哪個方案是對的。

另一個啟示是關於工具鏈的選擇。Steinberger 的整套工作流程都是反主流的：用 Codex 不用 Claude Code，不用 worktree，不用 MCP，不看 code。但他的產出效率和品質都極高。這說明在 AI 時代，最重要的不是用什麼工具，而是你對問題本身的理解有多深。工具會變、模型會更新、框架會淘汰，但那種「拆解問題 → 設計方案 → 驗證結果」的核心能力是不會過時的。

OpenClaw 在兩週內從零到 17 萬顆星星，本身就是 coding model 能力的最佳廣告。它告訴我們，AI 的能力邊界不在模型本身，而在我們給它多少自由去發揮。當你把 AI 從沙盒裡放出來，給它你電腦上所有的工具和資料，它能做到的事會超出你的想像。九秒搞定語音辨識只是一個開始。

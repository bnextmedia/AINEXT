---
title: "從 context 中毒到一人抵五人：coding agent 頂尖用戶的實戰守則"
date: 2026-02-10T11:00:00+08:00
description: "前 OpenAI Codex 工程師 Calvin French-Owen 在 YC Lightcone Podcast 分享 coding agent 的實戰心法：如何避免 context 中毒、為什麼超過 50% token 就該清空、測試覆蓋率如何讓開發速度暴增，以及大公司與小新創截然不同的採用策略。"
tags: ["Claude Code", "Coding Agent", "Context Window", "開發效率", "Podcast"]
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

## 一個「重新學會跑步」的故事

YC 合夥人 Jared Friedman 用了一個很到位的比喻來描述他使用 coding agent 的體驗。十年前他是個馬拉松跑者（寫程式），然後遭受了一次毀滅性的膝蓋傷害（變成管理者，不再碰程式碼）。現在他裝上了一副仿生膝蓋，不只恢復了原本的能力，還能跑得比以前快五倍。

這不是誇張。Jared 描述了一個具體場景：Claude Code 在他的終端機裡，可以追蹤五層巢狀的 delayed job，找出 bug、寫測試確保問題不再發生。他甚至讓 Claude Code 存取正式環境的資料庫來除錯一個並行問題。他坦言自己不確定「這樣做對不對」，但它就是能做到。

Calvin French-Owen 對此深有同感。他形容使用 coding agent 的感覺是「把一份 repo 複製一份給它，然後從門縫塞一張紙條進去，說：去實作這個東西。」這個 agent 不知道你的公司做什麼、你的客戶是誰，在大多數情況下，它對你的業務一無所知。能在這種條件下完成任務，本身就令人震驚。

但正因如此，context 的管理就變得非常重要。如果 agent 抓到了不對的 context，它沒有足夠的背景知識來自我修正；如果它漏掉了某個關鍵元素，它就會自己重新實作一個。

## 成為前 1% 用戶的四個原則

Diana Hu 在節目中問 Calvin：怎麼成為 coding agent 的前 1% 用戶？Calvin 給出了四個具體的建議，每一個都來自他在 OpenAI 和創業過程中的真實經驗。

**第一，盡量少寫膠水碼。** Calvin 的做法是把應用部署在 Vercel、Next.js 或 Cloudflare Workers 這類平台上，讓平台幫你處理大部分基礎設施。當你的整個應用只有一兩百行核心程式碼，coding agent 能理解的比例就大幅提高。他個人傾向使用微服務架構或結構清晰的獨立套件，讓每個模組都在 agent 的理解範圍內。

**第二，理解 LLM 的「超能力」是什麼。** Calvin 引用 Andrej Karpathy 最近的觀察：coding agent 最核心的特質是「超級執著」，它們會不停地嘗試，永遠不會放棄。而它們的另一個特質是「製造更多同樣的東西」，如果你的 codebase 裡某個 pattern 出現很多次，agent 就會繼續用同樣的方式寫更多。這意味著你在 codebase 裡留下的「種子」非常重要，因為那就是 agent 會複製和擴展的模板。Calvin 以 OpenAI 的巨型 monorepo 為例：裡面有超資深的 Meta 轉職工程師寫的生產級程式碼，也有剛入行的博士寫的實驗性程式碼。LLM 會根據你把它指向哪個區域，產出品質天差地遠的結果。

**第三，給模型檢查自身工作的方式。** 這包括三個層面：測試、linting 和 code review bot。Calvin 特別推薦了 YC 出身的 Reptile 作為 code review bot，他也會用 Cursor 的 bug bot 和 Codex 的 code review 功能。他發現 Codex 在「正確性」方面的 code review 做得特別好。

**第四，積極清除 context。** 這是 Calvin 反覆強調的一點，也是大多數用戶忽略的環節。他建議在 token 使用量超過 50% 時就主動清空 context，重新開始。這個數字比大多數人預期的要低得多。

## Context 中毒：coding agent 最隱蔽的陷阱

Calvin 提到的 context poisoning（context 中毒）是一個值得深入理解的概念。當 coding agent 在解決問題的過程中走錯了方向，它會把錯誤的推理寫進 context。接下來每一步的推理都會參考這些錯誤的 token，形成一個正回饋迴路。agent 越「執著」（這本來是它的超能力），在錯誤路線上就走得越深。

Calvin 引用了 YC 校友公司 HumanLayer 創辦人 Dex 的概念：LLM 的「笨蛋區」（dumb zone）。超過一定的 token 量之後，模型的輸出品質就會開始劣化。Calvin 用了一個精準的比喻：想像你是一個大學生在考試。開始的五分鐘，你覺得時間充裕，會仔細思考每一題。但當你發現只剩五分鐘卻還有一半沒寫，你就開始亂寫。LLM 面對 context window 末段的行為模式跟這很像。

Diana Hu 分享了一個業界流傳的技巧：在 context 的最開頭放一個「金絲雀」（canary）。這是一條隨機的、跟任務無關的資訊，比如「我叫 Calvin，我每天早上八點喝茶」。然後在工作過程中偶爾問模型：「我叫什麼名字？我什麼時候喝茶？」當模型開始忘記這些瑣碎資訊時，就是 context 已經中毒的訊號，該清空重來了。

Jared 認為這個問題應該可以在 Claude Code 內部解決，比如建立某種自動心跳檢測機制。Calvin 同意這個方向，但指出目前技術還沒到那一步。現階段的解法就是人工注意、主動清除。

## 新創全力衝刺，大公司小心翼翼

Calvin 觀察到 coding agent 的採用呈現一個有趣的兩極分化。

在小新創和業餘開發者那端，人們幾乎是毫無保留地擁抱 coding agent。Calvin 的說法很直接：「你跑道有限，沒時間搞其他的，就是以速度為中心來組織一切。」在 Jared 的案例中，他甚至會跳過所有權限確認（「100% skip permissions」），Garry Tan 則透露 YC 工程團隊內部大約是一半一半。Calvin 自己倒是屬於不跳過的那派，他會仔細看 agent 在做什麼。

大公司的情況完全不同。它們有更多的東西可以失去，內部有嚴格的 code review 流程，已經聘用了大型工程團隊。但 Calvin 預見了一個有趣的動態：大公司裡的個別團隊會開始用 coding agent 建構原型，而這些原型可能比既有方案更好。當一個人就能做出比整個團隊更好的東西，組織結構勢必要面臨重新洗牌。

Calvin 強調，越資深的工程師從 coding agent 中獲得的槓桿越大。因為 coding agent 最擅長的就是「把想法變成行動」。如果你能用幾個字把想法精準地表達成 prompt，接下來就是看著 agent 把它實現。他在 OpenAI 的日常就是這樣：走過 codebase，心裡想著「這邊要改、那邊要調」，然後把這些念頭一個個丟給 agent，讓它們回來交差。

## 測試覆蓋率：被低估的加速器

Jared 分享了一個讓他自己都驚訝的發現。他使用 coding agent 的前兩三天幾乎沒寫測試，開發速度已經很快了。但當他決定花一天把測試覆蓋率拉到 100% 之後，速度又暴增了一個量級。

原因很直覺：有了完整的測試覆蓋，他幾乎不需要手動測試。agent 寫完程式碼，跑一遍測試，過了就是過了。重構也不用怕，因為測試會告訴你哪裡壞了。這和傳統的測試驅動開發（TDD）理念一致，但在 coding agent 的加持下，效果被放大了好幾倍。

Diana Hu 把這個概念延伸到了 coding 以外的場景。她指出，在 prompt engineering 領域，最優秀的從業者也在用測試驅動的方式工作。測試案例就是你的 eval（評估標準），你先定義「好的輸出長什麼樣」，然後不斷調整 prompt 直到全部 eval 都過。

Calvin 則從訓練資料的角度呼應了這一點。他觀察到 Codex 在 Python monorepo 上的表現特別好，因為 OpenAI 內部就是以 Python 為主，訓練資料和研究者的使用習慣都集中在這裡。Anthropic 則更注重前端開發場景。不同的資料組合會導致模型在不同語言和框架上表現差異很大。Jared 分享了一個有趣的反例：他嘗試用 Codex 開發 Rails 專案，卻撞上各種問題，不是因為模型不懂 Ruby，而是因為 Codex 的沙箱環境沒有針對 Rails 的生態系（例如 Postgres 的存取方式）做過優化。

## 下一代工程師該學什麼

Garry Tan 問了 Calvin 一個假設性的問題：如果你回到大學，今天重新選擇要學什麼，你會怎麼安排？

Calvin 的回答分成兩部分。第一，系統基礎仍然很重要。理解 Git 如何運作、HTTP 協議、資料庫、佇列系統，這些基本功不會因為有了 coding agent 就變得不重要。它們是你對話的語言，是你用來向 agent 描述需求的基礎概念。

第二，花一個學期純粹做東西，每週一個專案，把模型推到極限。Calvin 描述了一種「不斷往上一層」的感覺：你有一個 implement 指令讓 agent 實作計畫的下一步，然後你可以做一個 implement all 指令讓它逐步完成整個計畫，再做一個 check your work 指令讓它自我驗證。知道模型在哪些層次上做得到、哪些做不到，是一個不斷移動的目標，值得持續探索。

Jared 則從另一個角度提出了他的擔憂。YC 每個批次都有一群 18 到 22 歲的年輕創辦人，這些人做過實習，但沒有真正管理過規模化的工程系統。當你的 job queue 有數百萬筆任務、數十萬筆錯誤要處理，那種「極度不光彩」的工程管理工作，是 coding agent 目前教不了的。Jared 的疑問是：下一代工程師能從 coding agent 學會架構思維嗎？還是必須摔了跤、讓使用者受了苦，才能學會？

Calvin 沒有給出明確答案，但他預測未來最成功的人會同時具備兩種能力：像經理人一樣思考工作流程和架構決策，以及像設計師一樣判斷產品該有什麼、不該有什麼。Garry Tan 則樂觀地認為，五年後最優秀的年輕工程師會擁有極高的「品味」，因為他們能更快地把想法化為產品、接觸真實世界、從回饋中學習。他們應該比上一代人多接觸十倍的「現實」。

這或許是 coding agent 時代最深刻的弔詭：工具越強大，人的判斷力就越值錢。

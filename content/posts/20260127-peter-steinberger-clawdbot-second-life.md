---
title: "從賣掉億元公司到退休崩潰，再到打造爆紅 AI 管家——Peter Steinberger 的第二人生"
date: 2026-01-27T10:00:00+08:00
description: "Peter Steinberger 曾創辦全球最大 PDF SDK 公司 PSPDFKit，以 1.16 億美元出場後卻陷入退休空虛。2026 年 1 月，他打造的開源 AI 助手 Clawdbot 一天暴增 9,000 顆 GitHub 星，累計超過 44,000 星，甚至帶動 Mac mini 銷量。這位奧地利開發者如何從人生低谷走出，成為 AI 時代最具行動力的建造者？"
tags: ["Peter Steinberger", "Clawdbot", "PSPDFKit", "開源", "AI Agent", "vibe coding"]
categories: ["領袖思維"]
source_url: "https://www.youtube.com/watch?v=68BS5GCRcBo"
source_name: "Elite AI-Assisted Coding"
draft: false
---

> 本文整理自 Elite AI-Assisted Coding 社群的 live coding session，並綜合 Peter Steinberger 的公開訪談與社群資料。

{{< youtube 68BS5GCRcBo >}}

---

## 你可能還不認識他，但你很快就會

2026 年 1 月 26 日，一個名叫 Clawdbot 的開源專案在 GitHub 上一天之內拿下 9,000 顆星，不到一週累計突破 44,000 星。它的 Discord 社群湧進將近 9,000 名成員，科技媒體爭相報導，連 Apple Mac mini 的銷量都因此被帶動——因為很多人買了一台專門拿來跑這個 AI 管家。

這個專案背後的人，是 Peter Steinberger，網路上大家叫他 steipete。

如果你是 iOS 開發者，你一定聽過他。如果你不是，那現在是時候認識他了。因為他正在用自己的方式，重新定義「一個人到底能做多少事」。

## 13 年 iOS 老將，一手打造全球最大 PDF SDK

Peter Steinberger 來自奧地利維也納。他在維也納工業大學（TU Wien）念書時，就開設了學校第一門 Mac/iOS 開發課程。2011 年，他決定暫停所有接案工作，嘗試做一個付費的 iOS 元件。那個元件叫做 PSPDFKit，是一個讓 App 能夠顯示、標註 PDF 文件的 SDK。

這個「實驗性的副專案」出乎意料地成功了。想像一下，當你在 Dropbox App 裡打開一份 PDF 檔案，看到的那個閱讀介面——那就是 PSPDFKit 的技術。IBM、漢莎航空，以及無數大大小小的企業都成了他的客戶。PSPDFKit 從 iOS 起步，逐步擴展到 Android、Web、Windows、macOS，最終覆蓋了所有主流平台。

最關鍵的是：PSPDFKit 從頭到尾都沒有拿過外部投資。Peter 花了十年時間，把它從一個人的副專案打造成一家跨平台的 B2B 軟體公司。

2021 年 10 月，私募基金 Insight Partners 以 1.16 億美元投資 PSPDFKit。Peter 和共同創辦人 Martin Schürrer 正式退出日常經營。

按照矽谷的劇本，故事到這裡應該是完美結局。但對 Peter 來說，真正的考驗才剛開始。

## 退休之後，他崩潰了

Peter 在多次公開場合坦承，離開 PSPDFKit 之後，他經歷了嚴重的倦怠與存在危機。經營了十多年的公司突然不再需要他，每天醒來不知道該做什麼——這種空虛感，比創業時期的任何挑戰都更難對付。

他嘗試過當投資人（目前是 Calm/Storm Ventures 的創投合夥人），也嘗試過純粹休息，但都填不滿那個洞。直到 AI 工具的爆發，讓他找到了重新投入的理由。

Peter 開始全力擁抱所謂的「vibe coding」——用 AI 輔助工具快速開發，以前所未有的速度把腦中的想法變成可以運作的產品。他從一個退休的旁觀者，變成 X（前 Twitter）上最高調、最多產的 AI 開發實踐者之一。

用主持人 Eleanor Berger 在 live session 開場時的描述：他是社群裡「最直言不諱、不停歇、毫不掩飾」的 AI 實踐者，而且他不只是說說而已，他真的在做。

## Clawdbot：不只是 AI 助手，是數位分身

Clawdbot 是 Peter 的最新作品，也是讓他再次站上風口浪尖的專案。

簡單來說，Clawdbot 是一個你可以架在自己電腦上的全能 AI 助手。它可以透過 WhatsApp、Telegram、Slack、Discord、Signal、iMessage 等你已經在用的通訊軟體跟你互動。它能幫你寄信、管行事曆、訂機票、處理保險理賠、操作瀏覽器、執行 shell 命令、管理 Git、甚至控制智慧家電。

跟 Siri 或 Google Assistant 最大的不同在於：Clawdbot 跑在你自己的硬體上，你的資料完全在你手中。它有長期記憶，能學習你的偏好，而且完全開源，你可以無限制地客製化。

更厲害的是，它能自我進化。當 Clawdbot 遇到它不會的任務（例如把影片轉成 GIF），它會自己寫一段程式碼、安裝到自己身上，下次就會了。Peter 把這稱為「Skill」機制。

Peter 在他的 LinkedIn 上寫道，Clawdbot 就是 Siri 應該成為但從未成為的東西。

## 為什麼爆紅？不只是產品好

Clawdbot 的爆紅當然跟產品本身有關——開源、自架、隱私友善、功能全面，這些特質在 2026 年的 AI 工具市場中形成了獨特的定位。

但如果只看產品，市場上類似的嘗試不少。Clawdbot 能在一天之內拿下 9,000 星，靠的不只是功能，更是 Peter Steinberger 這個人長年累積的社群信譽。

他在 iOS 開發者圈子裡經營了超過十三年。PSPDFKit 的成功不是靠行銷，是靠口碑。當一個有實績的開發者說「我做了一個東西」，大家的第一反應不是懷疑，而是去試。

這給了一個很重要的啟示：在 AI 工具氾濫的時代，品牌和信任就是最好的分發渠道。

## 我的觀察

Peter Steinberger 的故事，對我來說最有意思的不是 Clawdbot 有多酷，而是他折射出的一個正在浮現的趨勢。

越來越多像 Peter 這樣的資深開發者——有深厚的工程底蘊、有成功的產品經驗、但可能已經退休或半退休——正在透過 AI 工具重新找到創造力的出口。他們用 AI 的方式跟初學者截然不同。初學者容易被 AI 生成的程式碼帶著走，不知道什麼是對的、什麼會埋下隱患。但像 Peter 這樣的人，他知道好的架構長什麼樣、知道什麼地方不能妥協，AI 在他手裡就是一個超強的加速器，而不是方向盤。

這也解釋了為什麼他的 live coding session 標題叫做「You Can Just Do Things」（你就是可以直接去做）。在 AI 時代，阻止你做出東西的最大障礙，不再是技術門檻，而是你願不願意動手。Peter 用自己的人生證明了這一點——他從一場嚴重的退休危機中走出來，不是靠心理諮商或冥想，而是靠重新開始造東西。

另一個值得注意的點是 Clawdbot 的商業邏輯。它是開源的，但使用者需要自己付費訂閱 Anthropic 或 OpenAI 的 API。Peter 推薦搭配 Anthropic Pro 或 Max 方案，使用 Opus 4.5 模型。換句話說，Clawdbot 不是要跟 AI 公司搶生意，而是站在它們的肩膀上，提供一層「膠水層」——把各種 AI 能力黏合成一個真正可用的個人助手。這種商業思維，跟他當年做 PSPDFKit 的邏輯一脈相承：不做底層技術，做最上面那層讓使用者摸得到的體驗。

對台灣的開發者來說，Peter 的故事最直接的啟發可能是：別再等了。你不需要一個完美的計畫、一個完整的團隊、一筆充足的資金。你只需要一個想法、一台電腦、和願意跟 AI 一起動手的決心。Peter 在退休之後，一個人就做出了讓全世界矚目的東西。你也可以。

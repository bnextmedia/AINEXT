---
title: "別再造 Agent 了！Anthropic 說：2026 年是 Skills 的天下"
date: 2025-12-25T10:00:00+08:00
description: "2025 是 AI Agent 之年，但 Anthropic 已經在佈局下一步：Skills。這個新概念能讓 AI 像 CPA 一樣專業處理任務，而不只是聰明的數學家。Skills 是什麼？為什麼 Anthropic 說「別建 Agent，建 Skills」？"
tags: ["Anthropic", "Claude", "AI Agent", "Skills", "MCP", "AI 開發"]
categories: ["AI 產業"]
source_url: "https://www.youtube.com/watch?v=f8I4cGrDFYA"
source_name: "Break Even Brothers Podcast"
draft: false
---

2025 年被稱為「Agent 之年」，這點大家都同意。從年初開始，各大 AI 公司紛紛推出自己的 AI 代理人框架，讓 AI 能自主完成複雜任務。但就在年底，Anthropic 丟出一個新概念：Skills（技能）。他們甚至在 AI Engineer 頻道發布了一支標題很聳動的影片——「Don't Build Agents, Build Skills Instead」（別建 Agent，建 Skills）。這是什麼意思？Agent 時代這麼快就要過去了嗎？

在最近一集 Break Even Brothers Podcast 中，兩位主持人深入討論了 Skills 這個新趨勢。其中一位提到，Skills 幾個月前就已經在 Claude 中推出，但當時沒引起太大關注。「老實說，它當初推出時完全不在我的雷達上，」他坦言，「沒看到太多人使用，一開始的支援也有點粗糙——有點像 MCP Server 剛推出時的狀況。」但經過幾個月的打磨，Skills 開始展現真正的潛力，而且 OpenAI 也悄悄地在 ChatGPT 中加入了類似功能。

## 什麼是 Skills？用白話解釋這個概念

根據 Anthropic 官方的定義，Skills 是「描述如何執行特定任務的資料夾，包含說明文件、腳本和資源」。聽起來有點抽象，但 Podcast 主持人用了一個很好的比喻來解釋。想像你要報稅，你會選擇請一個非常聰明的數學家來幫你，還是請一個專業的會計師（CPA）？數學家可能數學能力超強，但他不懂稅法、不知道哪些項目可以抵扣、不清楚最新的報稅規定。會計師就不一樣了，他有領域專業知識（domain knowledge）。

Skills 就是用來填補這個落差的。現在的 AI 模型已經非常聰明，但它們缺乏特定領域的專業知識和流程。Skills 本質上是一個 Markdown 文字檔，用來描述 AI 應該如何執行某個特定任務。這個檔案可以包含步驟說明、需要使用的工具、要存取的 URL，甚至可以嵌入可執行的程式碼。當 Claude 判斷需要某個技能時，它會載入這個檔案，按照裡面的指示來完成任務。

這跟以往的 prompt engineering 有什麼不同？差別在於 Skills 是可以被分享、被版本控制、被市場化的標準化格式。你寫好一個報稅的 Skill，可以分享給同事；企業可以建立自己的 Skills 庫；未來甚至可能出現 Skills Marketplace，讓人們買賣專業技能檔案。Anthropic 在 2025 年 10 月推出 Skills，到了 12 月已經宣布支援組織級管理和合作夥伴目錄，發展相當快速。

## Skills vs MCP：差異在哪裡？為什麼更好用

如果你有在關注 AI 開發生態，應該聽過 MCP（Model Context Protocol）。這也是 Anthropic 推出的協議，用來讓 AI 呼叫外部工具。那 Skills 跟 MCP 有什麼不同？Podcast 主持人做了一個很精準的比較。

MCP Server 的問題在於它會「膨脹 context window」。每個 MCP 工具都需要一大段描述來告訴 AI 這個工具做什麼、怎麼用。當你想要加入很多工具時，20 萬 token 的 context window 很快就會被塞滿。這是技術層面的限制，而且安裝 MCP Server 也相當麻煩——需要安裝軟體依賴、設定環境變數，對非技術人員來說門檻不低。雖然 Cursor 等工具已經做了一鍵安裝的改進，但整體來說還是有點痛苦。

Skills 的設計就不一樣了。Claude 只會看到每個 Skill 的一兩行簡短描述，而不是完整的技術規格。只有當 Claude 判斷需要使用某個 Skill 時，它才會載入完整的文字檔。這樣可以保留更多 context window 空間給實際的工作內容。而且 Skills 本質上就是 Markdown 檔案，任何人都可以寫、可以編輯、可以分享。不需要寫程式、不需要架設伺服器，門檻低得多。

有趣的是，Skills 可以包含 MCP 工具的呼叫指令。所以它不是要取代 MCP，而是在 MCP 之上建立一個更高層次的抽象。你可以把 Skills 想成是「流程文件」，裡面可能會說：「第一步，用這個 MCP 工具抓取資料；第二步，用這個 URL 查詢資訊；第三步，用這個格式輸出結果。」它描述的是整個工作流程，而不只是單一工具。

## 財務分析、Excel 報表：Skills 的實際應用場景

Podcast 中提到，財務和會計領域是 Skills 的熱門應用場景。有人在 Twitter 上展示，裝載特定 Skills 後的 Claude 可以自動建立完整的三表財務模型——損益表、資產負債表、現金流量表都有。只要一個指令，AI 就能執行折現現金流分析、建立簡報，成品看起來很專業。

這跟 Claude 能處理 Excel、PowerPoint、Word 等微軟 Office 檔案的新功能有關。Anthropic 官方就提供了幾個內建 Skills，讓 Claude 可以讀取和生成專業的 Excel 試算表（含公式）、PowerPoint 簡報、Word 文件，甚至是可填寫的 PDF 表單。這對商業用戶來說非常實用。

不只是財務領域。Anthropic 的合作夥伴 Box 表示，Skills 讓使用者可以把儲存在 Box 的檔案轉換成符合組織標準的簡報和試算表，「節省了數小時的工作時間」。Canva 也計劃利用 Skills 來客製化設計代理人，讓團隊能夠捕捉獨特的設計脈絡。Rakuten 則用 Skills 來處理管理會計和財務工作流程，「以前需要一天才能完成的事，現在一小時就能搞定。」

更有意思的是，Skills 正在變成一種新的內容行銷手段。在 Twitter 上，有人會發文說：「回覆『財務模型』，我就把這個 Skill 的 .md 檔案寄給你。」這本質上是 lead magnet（吸引潛在客戶的免費資源），只是形式變成了 AI 技能檔案。當然，Podcast 主持人也警告，這裡面難免有些蹭熱度的「蛇油」產品，但整體趨勢是真實的。

## 「別建 Agent，建 Skills」：Anthropic 的範式轉移

Anthropic 在 AI Engineer 頻道發布的那支影片，標題很大膽：「Don't Build Agents, Build Skills Instead」。這背後的邏輯是什麼？

Podcast 主持人分析，Anthropic 的假設是：coding agent（程式碼代理人）將會是通用 AI 助手的最佳載體。為什麼？因為程式碼代理人有良好的邏輯推理能力，而且有完整的執行環境——可以寫 Python 腳本、執行程式、取得輸出結果。這是一個封閉且可控的工作環境。

在這個前提下，問題就變成：如何讓這些通用的 coding agent 獲得特定領域的專業知識？答案就是 Skills。與其投入大量時間開發專門的 Agent，不如寫好描述流程的 Skill 檔案，讓通用 Agent 在需要時載入使用。這樣做有幾個好處：開發成本更低（只要寫文字檔）、維護更容易（改個文字檔就好）、分享更方便（傳個檔案就行）。

這讓人想到 ChatGPT 之前推出的 GPTs 功能。GPTs 也是一種客製化的 AI 配置檔，但它們不容易分享、不容易在企業內部維護、版本控制也很麻煩。Skills 可以說是 GPTs 的進化版，加上 MCP 的工具呼叫能力，但設計成更容易使用和分享的格式。Anthropic 在 12 月還推出了 Agent Skills 作為開放標準，讓 Skills 可以跨平台使用，不只限於 Claude 生態系。

## 2026 年的 Skills Marketplace 展望

OpenAI 已經悄悄在 ChatGPT 中加入了 Skills 功能。據 Podcast 主持人透露，如果你問 ChatGPT「你有哪些 skills」，它會列出自己內建的五到十種能力。這代表這個方向已經獲得主要 AI 實驗室的認可，不是 Anthropic 一家在唱獨角戲。

展望 2026 年，Skills Marketplace（技能市場）很可能會成為現實。想像一下：專業會計師可以銷售他們精心打造的報稅 Skill；行銷專家可以販售社群媒體分析 Skill；律師可以提供合約審查 Skill。這些 Skill 可以包含多年累積的專業知識和最佳實踐，買家付費購買後就能讓 AI 獲得這些能力。

當然，這也帶來新的挑戰。Skills 本質上是可執行的程式碼，這意味著安全性是個問題。Anthropic 的官方文件也提醒使用者要謹慎選擇來源，只使用可信賴的 Skills。未來可能需要某種認證機制或審核流程，確保 Skills Marketplace 不會變成惡意程式的溫床。

2025 是 Agent 之年，這個判斷沒有錯。但技術發展總是一浪接一浪。Anthropic 已經開始佈局下一個階段，把重心從「建造更聰明的 Agent」轉向「賦予 Agent 專業技能」。這是否代表 Agent 開發的終結？當然不是。但它確實揭示了一個趨勢：AI 越來越強大之後，關鍵差異化將來自專業知識的封裝和分享方式。誰能建立最好的 Skills 生態系，誰就可能在下一輪競爭中佔據優勢。

本文整理自 Break Even Brothers Podcast 2025 年 12 月底播出的單集。

---
title: "OpenAI 共同創辦人 John Schulman 深度訪談：從 ChatGPT 的早產可能，到 RL 研究的未來"
date: 2026-01-22T10:00:00+08:00
description: "John Schulman 是 PPO 演算法發明者、OpenAI 共同創辦人，現創辦 Thinking Machines。這場訪談涵蓋 OpenAI 早期文化、研究管理哲學、技術觀點（value functions、持續學習、多智能體訓練），以及他對 AGI 時程與 AI 實驗室協作的看法。"
tags: ["John Schulman", "OpenAI", "Reinforcement Learning", "PPO", "Thinking Machines", "Podcast"]
categories: ["AI 產業"]
source_url: "https://www.youtube.com/watch?v=29BYxvvF1iM"
source_name: "Cursor Podcast"
draft: false
---

> 本文整理自 Cursor Podcast 2025 年 12 月播出的訪談。

{{< youtube 29BYxvvF1iM >}}

{{< spotify "episode/0spjPM7YOd9UvFdS7hIgla" >}}

{{< apple-podcast "tw/podcast/john-schulman-on-dead-ends-scaling-rl-and-building/id1819406817?i=1000741762325" >}}

---

John Schulman 是 AI 領域最重要的研究者之一。他發明了 PPO（Proximal Policy Optimization）演算法，這是目前大型語言模型 RLHF 訓練的核心技術。他是 OpenAI 的共同創辦人，在那裡待了近十年，領導強化學習研究團隊。2024 年離開後，他創辦了 Thinking Machines，推出低階微調 API「Tynker」。

這場長達一小時的訪談，涵蓋了他對 AI 研究的深刻洞見。

---

## ChatGPT 可以更早誕生嗎？

訪談一開始就丟出大哉問：如果 2015-2016 年的 OpenAI 團隊擁有現在的知識，能多快做出 ChatGPT？

Schulman 的答案出人意料：**2018 或 2019 年，只需要幾個人。**

他引用 NanoGPT（Andrej Karpathy 的極簡實作）為例，說明許多技術突破其實可以用更少的運算資源達成。關鍵在於：

1. **Post-training 技術**：現在我們知道如何透過精心設計的微調資料集，讓小模型表現得像大模型
2. **預訓練資料集**：站在他人建構的資料集基礎上
3. **整體配方**：知道該往哪個方向走

他甚至預測，未來可能出現「demo scene 版 ChatGPT」——一個檔案、一天訓練、從頭爬網到完成模型。

---

## OpenAI 早期：學術風格的「和平時期」

Schulman 形容早期 OpenAI 是「ragtag」（雜牌軍）風格，更像學術研究群。一到三人的小團隊，根據個人品味做研究，產出論文或部落格文章。

同時，他們也受 DeepMind 影響，嘗試大型工程專案。但並非所有專案都成功。

**Universe 專案**是個典型的「正確但太早」案例。概念是建立大量 RL 環境（電玩遊戲、網頁導航任務），訓練出能泛化的通用 RL agent。

Schulman 說：「這是個 deeply correct idea，但太早了——可能早了十年。」當時缺乏太多前提條件，系統笨重難用，從零訓練的模型也無法泛化。最後，團隊縮小範圍到模擬器電玩，才獲得更好成果。

機器人專案也是類似命運——對公司來說是死胡同，但培養了做大型工程研究專案的能力。

---

## 研究管理的兩種模式

被問到理想的研究主管是什麼樣子，Schulman 說這是個「non-stationary problem」——七八年前有效的做法，現在不一定適用。

他觀察到兩種成功模式：

**Hands-on 模式**：
- 主管自己寫很多程式碼
- 閱讀報告的所有程式碼
- 給予詳細技術反饋
- 適合：目標導向研究、較資淺團隊

**Hands-off 模式**：
- 當 sounding board（迴音板）
- 提供職涯建議而非技術細節
- 讓人保持開心與動力
- 適合：探索性研究、資深個別貢獻者

---

## 技術觀點：Value Functions、持續學習、脆弱泛化

### 為什麼 Value Functions 現在不流行？

Value functions 在傳統 RL 任務中能有效減少 variance，但在目前的 RLHF 和可驗證獎勵任務上，效果不明顯。原因不明，但 Schulman 預期它們會捲土重來。

### 持續學習怎麼解？

Schulman 區分不同類型的學習（類比心理學的 motor learning、episodic memory、procedural memory），認為：

- **In-context 學習**：短期時間軸難以超越
- **參數微調（如 LoRA）**：長期時間軸會勝出
- 兩者會堆疊使用

### 模型的脆弱泛化是障礙嗎？

模型在 in-context 學習上的 sample efficiency 可以媲美甚至超越人類，但某些訓練需要的資料量遠超人類學習。

關鍵差異：**人類被演化優化到 80 年的時間軸**，有大量自我修正機制。模型在長時間軸任務上容易卡住。這是暫時現象還是根本弱點？需要數十年才能驗證。

---

## 共同訓練與多智能體遊戲

Schulman 看好兩個方向：

### Generator-Verifier 共同訓練

理論上能實現自我改進——模型在推理和遵循指令上變強，同時成為更好的驗證者，形成良性循環。

### 多智能體遊戲訓練

設計零和或多人遊戲，讓均衡解是有趣的。遊戲的好處：

1. **自動課程學習**：對手與你同步變強
2. **理論優勢**：複雜度理論顯示，用便宜的判斷過程，可以創造出需要解決極難問題的均衡

他特別提到 **debate game**（辯論賽局）在 alignment 領域的潛力，預期這類想法會越來越重要。

---

## AI 如何改變研究工作流

Schulman 每天大量使用 AI：

- **Cursor 和 Claude Code** 寫程式
- **GPT-5 Pro** 做文獻搜尋、發展想法
- **聊天模型**當寫作的第一輪反饋

他 2020 年寫過一篇關於如何做有效研究的部落格，現在大部分建議仍適用。但有一個重大改變：

**研究筆記本現在更重要了。**

因為 context 對 LLM 至關重要。把筆記本貼給 LLM，就能獲得有脈絡的反饋。

但他也警告：**研究工作不該讓 AI 寫大量你沒讀過的程式碼。**

在其他軟體工程領域，定義規格讓模型實作是可行的。但研究不同——做出最好成果的人，對每一行程式碼都瞭若指掌。

---

## AI 領域的人才變化

2015-2017 年進入領域的人「比較怪」。現在 AI 已是主流共識，吸引更多傳統職涯路徑、風險趨避的人。

更重要的變化：**工程能力現在比研究品味更重要。**

原因：
1. Scaling 簡單想法帶來大量成果，低垂果實很多
2. 領域成熟，你是在別人的 codebase 上建構
3. 需要整合大量他人的程式碼和工具

有軟體工程背景的人更有優勢。

---

## RL 研究的未來

Schulman 認為 ideas 會循環流行。Offline RL 是個有趣方向。

目前 LLM 領域做的事，某種程度上是 **Sim2Real**——在大量模擬環境做 RL，期望泛化到真實世界。Sim2Real 在機器人領域仍然有效。

但他預期：**從真實部署學習**會回到 LLM 領域。如何從真實世界互動中學習，是下一個重要問題。

---

## AGI 時程與 AI 實驗室協作

### 低估時程的偏誤

Schulman 同意工程師和研究者習慣性低估專案時程，通常要乘以 2-3 倍。自駕車是最類似的案例——全自動駕駛和 robotaxi 比預期晚很多。

但另一方面，**AI 加速自身發展的正向回饋**可能打破直覺。納入這個因素的人，得出很短的時程預測。

他不做自信的預測。

### 頂尖 AI 實驗室會協作嗎？

Schulman 說「中等擔心/有信心」。各實驗室有相當多共同願景，近期在安全議題上有合作。但也有一些「bad blood」（舊怨）可能造成障礙。

如果情勢明確需要協作，他認為可能會成功。

---

## Thinking Machines 的 Tynker

Schulman 的新公司推出 Tynker——低階微調 API。

核心概念：提供一組低階 primitives 做訓練和採樣，能表達幾乎所有 post-training 演算法，但不用管 GPU、加速器、分散式系統。

最接近的類比是 OpenAI/Anthropic 的採樣 API——你不用自己架 GPU 做推論，只要呼叫 API。Tynker 讓你用 Python 腳本寫訓練程式碼，不用擔心底層設定。

目前適合對 ML 有深入了解、想用低階 primitives 的人。未來會加入更多高階元件，讓非專家也能使用。

願景：**未來的 AI 公司能直接建構在 Tynker 上，不用自己發展基礎設施。**

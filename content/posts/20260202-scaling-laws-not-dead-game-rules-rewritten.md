---
title: "Scaling Laws 還沒撞牆，但遊戲規則正在改寫"
date: 2026-02-02T11:00:00+08:00
description: "Sebastian Raschka 與 Nathan Lambert 在 Lex Fridman Podcast 拆解 AI 三大 scaling 路線的最新進展。從 pre-training 的成本困境、RLVR 如何成為真正的遊戲改變者，到 MoE 架構與 text diffusion 等替代路線，兩位研究者為 2026 年的技術版圖描繪出比「撞牆」複雜得多的真相。"
tags: ["Scaling Laws", "RLVR", "Lex Fridman", "Sebastian Raschka", "Nathan Lambert"]
categories: ["AI 技術前沿"]
image: "/images/posts/20260202-scaling-laws-not-dead-game-rules-rewritten.webp"
source_url: "https://www.youtube.com/watch?v=EV7WhVT270Q"
source_name: "Lex Fridman Podcast"
related_companies: ["openai", "anthropic", "google-deepmind", "deepseek", "nvidia"]
related_people: ["lex-fridman"]
draft: false
---

> 本文整理自《Lex Fridman Podcast》2026 年 2 月播出的第 490 集。

{{< youtube EV7WhVT270Q >}}

{{< spotify "episode/4UBPQG2Z7s70DpRVD5kMbC" >}}

{{< apple-podcast "tw/podcast/490-state-of-ai-in-2026-llms-coding-scaling-laws/id1434243584?i=1000747523558" >}}

---

> **本文是 Lex Fridman Podcast #490 系列整理的第二篇，共四篇：**
>
> 1. [AI 寫程式的真相：從 Vibe Coding 到軟體工程的未來](/posts/20260202-ai-coding-reality-vibe-coding-software-future/)
> 2. **Scaling Laws 還沒撞牆，但遊戲規則正在改寫**（本篇）
> 3. [開源 vs 閉源、中國 vs 美國：AI 的新冷戰已經開打](/posts/20260202-open-vs-closed-china-us-ai-cold-war/)
> 4. [通往 AGI 的路上，我們更可能先遇到什麼？](/posts/20260202-road-to-agi-amplification-not-revolution/)

## 同一個架構，居然撐了這麼久

Lex Fridman 這集找來了兩位在 AI 技術前線工作的研究者。Sebastian Raschka 是 Lightning AI 的資深研究工程師，也是暢銷書《Build a Large Language Model (From Scratch)》與《Build a Reasoning Model (From Scratch)》的作者。Nathan Lambert 則是艾倫人工智慧研究所（AI2）的後訓練團隊負責人，主導 Atom Project（美國開放模型計畫），去年出版了 RLHF 領域的重要著作《Reinforcement Learning from Human Feedback》。

在這場近五小時的對談中，三人花了大量時間拆解一個讓外界困惑的現象：AI 的能力明明在過去一年飛速成長，但底層的 Transformer 架構幾乎沒變。Sebastian 用他「從零建構」的經驗做了示範：從 GPT-2 到今天的 Qwen3、DeepSeek V3、GPT-OSS，你只需要加上 MoE（混合專家）層、把 LayerNorm 換成 RMS Norm、把 multi-head attention 改成 group query attention，就差不多了。「本質上是同一個架構。你可以從一個轉換到另一個，只需要加上這些改動。」

如果架構沒變，那進步從哪裡來？答案是三條不同的 scaling 路線同時在推進。

## 三條 scaling 曲線，每條都還在動

Nathan Lambert 對 scaling laws 的定義很精確：它描述的是計算量（compute）與模型在未見過的文本上的預測準確度之間的冪次法則關係。這個關係跨越了 13 個數量級的計算規模，至今依然成立。「很多 AI 公司領導層會說，它已經在 13 個數量級上維持了，為什麼會突然停下來？」

但在這個基本框架下，現在有三條不同的 scaling 軸線同時在跑。第一條是傳統的 pre-training scaling：更大的模型、更多的資料、更長的訓練時間。第二條是強化學習的 scaling，特別是 RLVR（Reinforcement Learning with Verifiable Rewards），讓模型透過反覆嘗試來學習推理和工具使用。第三條是 inference-time compute，讓模型在回答之前「想更久」。

Nathan 的判斷是：三條曲線都還在動，但各自卡在不同的瓶頸。Pre-training 的成本高到讓人猶豫還要不要繼續加碼。RLVR 是過去一年最大的突破口，但低垂的果實正在被摘完。Inference-time scaling 帶來了最明顯的體驗改善，但也讓每次查詢的成本變得難以預估。

Sebastian 補充了一個很實際的經濟學角度。Pre-training 的花費是一次性的固定成本，模型訓練完就永遠擁有那個能力。但 inference-time scaling 的成本是按查詢計費的，而且模型在市場上的壽命可能只有半年就被取代。「也許花一億美元做 pre-training 不值得，不如把錢花在 inference scaling 上，用兩百萬美元的使用者查詢費來換取同等性能。」但這背後有個前提：你有多少使用者？使用者願意付多少錢？這些商業考量正在影響技術路線的選擇。

## RLVR：「50 步就從 15% 跳到 50%」

在三條 scaling 路線中，RLVR 是過去一年進展最猛的一條。Nathan Lambert 是 RLVR 這個名詞的共同創造者（源自 AI2 在 2023 年的研究），不過真正把它推向大眾視野的是 DeepSeek R1。

RLVR 的核心概念不難理解：給模型一個有明確正確答案的問題（數學或程式碼），讓它反覆嘗試，答對了就給獎勵。跟傳統的 RLHF（根據人類主觀偏好訓練）不同，RLVR 用的是客觀的可驗證標準，所以可以持續擴大訓練規模，不會碰到偏好飽和的問題。

Sebastian 用一個自己動手的實驗來說明效果有多驚人：他拿一個基礎模型在 MATH 500 測試集上跑，原始準確率只有 15%。用 RLVR 訓練 50 步，只花了幾分鐘，模型準確率就跳到 50%。「你不可能跟我說它在 50 步裡學到了任何關於數學的基礎知識。知識已經在 pre-training 裡了，RLVR 只是把它 '解鎖' 出來。」

Nathan 對此的補充比較謹慎。他指出這個實驗有個特殊性：部分模型（特別是 Qwen 系列）在 mid-training 階段可能已經接觸過跟測試集高度相似的資料，有污染的疑慮。但他同意核心洞察是對的：RLVR 不是教模型新知識，而是放大模型已經具備但還沒展現出來的能力。

RLVR 訓練過程中還會自發出現一些有趣的行為。Sebastian 舉了 DeepSeek R1 論文中著名的「Aha moment」：模型在推理過程中自己發現錯誤、自己修正，產生了類似數學家在草稿紙上演算的逐步推理過程。「你只給它問題和答案，然後它自己發展出一步一步的解題過程，甚至會自我修正。這真的很酷。」

Nathan 給了一個比較冷靜的解讀：這些「Aha moment」可能不是真正的頓悟。模型在 pre-training 中已經見過類似的行為模式，數學講座的逐字稿裡就充滿了「等等，我搞錯了，讓我重新算」這樣的表述。RLVR 只是大幅放大了這些已有的模式，因為它們在解題時確實管用。

## RLVR 的下一步：從只看答案到評估過程

Sebastian 提出了他認為今年最重要的技術方向：RLVR 2.0。目前的 RLVR 只看最終答案對不對，完全不管模型的推理過程。但已經有研究（包括 Google 的工作）在開發 Process Reward Models（PRM），能對模型推理的每一個中間步驟給分。也就是說，未來不只看「答對了沒」，還看「解題過程合不合理」。

這個方向的潛力很大，能讓模型的推理品質更穩定、也更容易解釋。但 Nathan 也點出了一個實務挑戰：問題越來越難，RLVR 需要在更複雜的領域找到新的訓練信號。數學和程式碼的驗證相對容易，但科學問題呢？法律問題呢？Nathan 提到已經有數億美元融資的新創公司在嘗試把 RLVR 應用到「濕實驗室」場景，讓語言模型跟真實的生物實驗對接。這是 RLVR 能否從「解數學題」升級到「做科學」的關鍵戰場。

## MoE：讓模型變大但不變貴

三人花了不少時間解釋 Mixture of Experts（MoE）架構，這是過去一年開源模型競爭中最重要的技術趨勢之一。

Sebastian 的解釋很直觀：標準 Transformer 裡，每一層有一個全連接（fully connected）的前饋網路，每次推理都要全部算過一遍。MoE 的做法是把這個前饋網路拆成很多個「專家」（比如 256 個），但每次只根據輸入的 token 選用其中幾個。「你把更多的知識塞進網路裡，但不是所有知識都同時啟用。根據輸入內容，有一個路由器（router）決定哪些 token 該送給哪個專家。」

這個設計讓模型的「總參數量」可以很大（等於塞進更多知識），但每次推理的「活躍參數量」保持在可控範圍（速度和成本不會暴增）。DeepSeek 的成功很大程度上靠的就是 MoE 架構，加上他們獨創的 multi-head latent attention 機制來壓縮 KV cache，讓推理時更省記憶體。

Nathan 觀察到一個有趣的分化：中國的開放模型傾向做更大的 MoE 架構來衝峰值性能，美國和歐洲的開放模型（Gemma、Nemotron、GPT-OSS）過去則傾向做較小的密集（Dense）模型。但這個格局正在變。2025 年底，Mistral 推出了類似 DeepSeek 架構的大型 MoE 模型，NVIDIA 和 RCAI 也預告了 400 億參數以上的 MoE 模型即將在 2026 年第一季問世。「美國和歐洲的開放模型在規模上追上中國模型的時間表，可能比很多人預期的更快。」

## 替代架構：Text Diffusion 是不是下一個大事？

除了在 Transformer 框架內做改進，有沒有完全不同的路線？Sebastian 認為 text diffusion 是目前最有看頭的替代方向。

Text diffusion 借鑑了圖像生成的擴散模型概念。圖像生成的做法是，模型從一張充滿雜訊的圖片開始，逐步去噪直到產生清晰的圖像。Text diffusion 把同樣的邏輯套用到文字上：不像 GPT 那樣一個 token 一個 token 地生成，而是從一段「雜亂」的初始文字開始，透過多次迭代逐步精煉，每次可以同時修改多個 token。

這個做法最大的賣點是速度。Nathan 舉了一個已經在實務中使用的例子：有些程式碼新創公司用 text diffusion 來生成大型的 code diff（程式碼變更），因為用傳統的自回歸模型逐 token 生成會花好幾分鐘，每多等一秒就流失一批使用者。Text diffusion 可以一次性生成整段差異碼，速度優勢非常明顯。

但 Sebastian 也直說了限制：text diffusion 在需要順序推理和工具呼叫的場景下很吃力。「如果你的模型需要在推理中間呼叫一個 Python 直譯器，拿到結果後再繼續，這在 diffusion 的框架裡很難做到。」Google 已經推出 Gemini Diffusion，據說在多數基準測試上能達到跟 Gemini Nano 2 同等品質但更快的生成速度。Sebastian 的判斷是：text diffusion 不會取代自回歸 LLM，但可能成為免費版或快速回應場景的首選方案。

## 資料品質戰爭：合成資料的兩面性

除了架構和訓練方法，資料品質是另一個正在改變遊戲規則的戰場。Sebastian 和 Nathan 都強調，現在做 pre-training 不再是「把網路上能找到的東西全部丟進去」這麼粗暴了。

Nathan 以 AI2 的 OLMo3 模型為例：他們在資料混合比例（data mix）的優化上花了大量心力，包括用分類器篩掉低品質內容、把 Wikipedia 文章改寫成 Q&A 格式、從 OCR 處理過的 PDF 中提取和清理文字。這些「合成資料」不是 AI 憑空捏造的東西，而是用模型來清理、重組、精煉已有的人類知識。

Sebastian 用了一個直覺的比喻：「人類從一本結構清晰的教科書學到的東西，跟從一篇雜亂的 Reddit 貼文學到的東西，品質是不一樣的。模型也是。」高品質的合成資料讓模型用更少的 token 就能學到同等甚至更多的知識，等於在不增加訓練時間的情況下提升了效率。

但合成資料有一個繞不開的雞生蛋問題：好的合成資料需要好的模型來生成和驗證，好的模型又需要好的資料來訓練。Nathan 暗示，這也是 RLVR 成為核心突破的原因之一。RLVR 繞過了人類標註的瓶頸（RLHF 需要人類標註偏好，成本高且容易飽和），直接用可驗證的客觀標準作為獎勵信號，讓資料品質的循環能持續轉動下去。

另一個更敏感的議題是資料授權。Sebastian 提到，越來越多的網路平台關閉了公開存取（Reddit 收授權費、出版社提告），能取得高品質專有資料（如臨床試驗記錄、法律文書）會成為前沿實驗室之間拉開差距的關鍵。

## 我的觀察：三條曲線疊加的真正意義

過去一年 AINEXT 追蹤了不少 AI 領袖的觀點。Eric Schmidt 在去年的 AI 國家安全論壇上強調算力競賽的重要性。Demis Hassabis 在 GTC 2025 畫出了從 Gemini 到 AGI 的路線圖。Sam Altman 則在各種場合不斷重複「scaling 正在加速」。但每個人強調的重點不同：Schmidt 看算力、Hassabis 看架構演進、Altman 看商業應用。

Sebastian 和 Nathan 的這場對談提供了一個更完整的圖像。重點不是哪一條 scaling 曲線比較重要，而是三條曲線同時在推進，而且彼此疊加。Pre-training 提供基礎能力，相當於模型的「知識庫」。RLVR 讓模型學會使用工具和推理，把知識轉化為「技能」。Inference-time compute 讓使用者按需付費換取更強的結果，把技能轉化為「產品體驗」。三者的疊加效應，才是 AI 進步速度超出多數人預期的真正原因。

## 楊立昆說的「不只有 Transformer」，開始有了證據

去年在 GTC 2025，Meta 首席 AI 科學家楊立昆（Yann LeCun）斷言他「對 LLM 已不感興趣」，認為自回歸語言模型不是通往更高階 AI 的正確路線。當時很多人覺得言之過早。

Sebastian 在這集提到的 text diffusion models、gated delta net（Qwen3Next 採用的新型注意力替代機制）、以及 Mamba 等狀態空間模型，至少在研究圈開始印證了 LeCun 的判斷。架構多元化的趨勢確實正在發生。問題不是 Transformer 會不會被取代，而是它會不會像 RNN 一樣，變成「夠好但不是唯一」的選項。Sebastian 自己的評估很務實：「Transformer 仍然是 state-of-the-art，沒有任何替代方案能在品質上超越它。但它不再是唯一的選項了。」

## 臺灣讀者該關注什麼

對臺灣的 AI 從業者和企業來說，Scaling Laws 持續有效其實是好消息。這代表你不需要自己發明新架構，只要持續跟上最新的開源模型迭代，就能享受到能力提升的紅利。臺灣有世界級的半導體製造能力，AI 應用層面也不缺優秀的工程師，但多數企業是模型的「使用者」而非「訓練者」。

在這個框架下，真正該盯的不是 pre-training 的成本有多高（那是 OpenAI 和 Google 要煩惱的事），而是 inference-time compute 帶來的成本結構變化。當「模型想越久答案越好」成為產品常態，你的應用定價策略、用量規劃、甚至使用者體驗設計都得重新思考。Nathan 在節目中提到今年可能出現每月 2000 美元的訂閱方案，這不是天方夜譚，而是 inference-time scaling 商業化的自然結果。

另一個值得追蹤的趨勢是開放 MoE 模型的崛起。2026 年第一季，NVIDIA、Mistral、RCAI 都將推出大型 MoE 開放模型，這會直接影響臺灣企業做本地化部署和微調的可能性。過去只有中國的 DeepSeek 提供頂級的開放 MoE 模型，未來選擇會更多。

![封面圖](/images/posts/20260202-scaling-laws-not-dead-game-rules-rewritten.webp)

---
title: "7 小時 vs 2 週——AI 編程的 10 倍速真相與代價"
date: 2025-12-25T13:00:00+08:00
description: "一個週六下午，35,000 行程式碼。HumanLayer 創辦人 Dex Horthy 分享他在 300,000 行 Rust codebase 中 one-shot fix 的實戰案例，以及在 Parquet Java 慘遭滑鐵盧的經驗。10 倍速的代價是什麼？"
tags: ["AI 編程", "Dex Horthy", "HumanLayer", "BAML", "Rust"]
categories: ["AI 產業"]
source_url: "https://www.youtube.com/watch?v=rmvDxxNubIg"
source_name: "AI Engineer World's Fair 2025"
draft: false
---

{{< youtube rmvDxxNubIg >}}

---

> 本文整理自 AI Engineer World's Fair 2025 的演講「No Vibes Allowed: Solving Hard Problems in Complex Codebases」。

7 小時完成 2 週的工作量。35,000 行程式碼。一個週六下午。

這是 Dex Horthy 和他朋友 Vaibhav 的瘋狂實驗結果。Vaibhav 是 BoundaryML 的 CEO，他們家的產品叫 BAML，是一個用 Rust 寫的程式語言。整個 codebase 大概 300,000 行 Rust code。

這不是什麼 Vercel dashboard 的 greenfield 專案。這是正經的棕地開發，複雜的真實世界程式碼。

## 案例一：300,000 行 Rust 的 One-Shot Fix

故事要從 Dex 的 podcast 說起。他跟 Vaibhav 一起做節目，有一天他說：「我想試試看能不能 one-shot 修掉你們 codebase 裡的一個 bug。」

這是一個行銷噱頭，也是一個真實的測試。他想證明他那套 Research-Plan-Implement 的工作流程在大型、複雜的棕地程式碼庫裡也行得通。

他們花了大概一個半小時錄節目（你可以去聽），過程中他做了幾份研究文件，有些寫完就扔掉因為方向錯了，然後做了兩份計畫文件——一份沒有 research 基礎的，一份有的——比較結果。

週一晚上開始做，週二早上他們錄節目的時候，BAML 的 CTO 已經看過那個 PR 了。他沒意識到這是 podcast 的噱頭，只是覺得：「嗯，這看起來沒問題，我們下個版本會 merge 進去。」

搞了半天，Dex 是當 bit 在玩，結果人家真的要用。

## 案例二：35,000 行 Code 的瘋狂週六

Vaibhav 看了那個 one-shot fix 之後還是有點懷疑。OK，修一個小 bug 可以，但能處理更複雜的任務嗎？

所以他們約了一個週六，從早做到晚，七個小時，看能搞出什麼東西。

結果：35,000 行程式碼。

Dex 有說明這個數字需要打折扣——有些是 code generated 的東西，你改了一個行為，所有的 golden test files 都跟著更新，那個數字就衝上去了。但扣掉這些，他們還是做了相當多實質的工作。

Vaibhav 估計，同樣的事情正常做大概需要一到兩週。他們用七個小時搞定。

其中一個 PR 一週後就被 merge 了。真的上線了。

## 失敗案例：Parquet Java 的滑鐵盧

講成功案例很容易，但 Dex 也講了一個失敗案例。

他跟另一個朋友 Blake 試著從 Parquet Java 裡面移除 Hadoop 的依賴。如果你知道 Parquet Java 是什麼，Dex 說他很遺憾，不知道你的職業生涯經歷了什麼才讓你走到這一步。

這件事完全失敗了。

他們照著同樣的流程做：research、plan、implement。做了很多份研究文件，做了計畫。但最後他們把全部東西都扔掉，回到白板前面，從頭開始想這件事到底應該怎麼做。

問題出在哪？

不是工具不行，是問題本身太難。當他們透過 research 階段發現了所有的地雷在哪裡之後，他們意識到這不是一個「執行計畫」就能解決的問題。這需要人類的架構設計能力，需要坐下來想「這些東西到底應該怎麼 fit together」。

這帶出一個很重要的結論。

## AI 只能放大思考，不能取代思考

Dex 用一句話總結這個教訓：

「AI cannot replace thinking. It can only amplify the thinking you have done, or the lack of thinking you have done.」

AI 不能取代思考。它只能放大你做過的思考——或者放大你沒做的思考。

在 BAML 的案例裡，問題相對清楚，解法也相對直接。一旦你做好 research 知道程式碼怎麼運作，plan 寫好執行步驟，AI 就可以高速把 code 生出來。

在 Parquet Java 的案例裡，問題本身就很模糊。沒有人知道「正確」的做法是什麼，因為這是一個架構決策，需要權衡各種 trade-off。AI 可以幫你探索 codebase，但最終的決定必須由人類來做。

這也解釋了那張著名的圖表：問題越複雜、codebase 越大，你需要的前置準備就越多。在「小問題 + 小 codebase」的情況，直接問 AI 就行。在「複雜問題 + 大 codebase」的情況，你需要完整的 research-plan-implement 流程，而且即使這樣也不保證成功。

## 10 倍速的代價

所以，7 小時完成 2 週的工作量，代價是什麼？

代價是你要花時間做 research，要花時間寫 plan，要花時間讀那些文件確認 AI 的理解是對的，要花時間驗證 plan 的每一步是合理的。

代價是你不能「憑感覺」。你不能只是把問題丟給 AI 然後祈禱它會做對。你需要一個紀律，一個流程。

代價是你要累積經驗。「這個任務需要多少前置準備？」沒有標準答案，要靠經驗判斷。你會判斷錯，有時候做太多，有時候做太少。這沒關係，重點是累積經驗值。

Dex 說他不建議在 Claude Code、Codex、Cursor 之間來回跳。挑一個工具，用熟它。

## 不是更好的 Prompt，是更好的流程

如果你只記住這場演講的一件事，Dex 說應該是這個：

「A bad line of code is a bad line of code. A bad part of a plan could be 100 bad lines of code. A bad line of research could hose your whole thing.」

一行爛 code 就是一行爛 code。計畫裡一行錯誤的描述，可能導致一百行爛 code。研究文件裡一個錯誤的理解，可能讓整個專案走偏。

槓桿作用是往上累積的。你在越高層級抓到問題，省下的時間越多。這就是為什麼他們把人類的注意力和 review 重心放在 research 和 plan，而不是最後的 code。

這不是什麼新的 prompt engineering 技巧。這是流程設計，是工作方式的改變。

## 真正的挑戰在後面

Dex 預測，coding agent 本身會逐漸商品化。怎麼用這些工具、怎麼管理 context，這些技能會變成基本功，大家都會。

真正的挑戰是：你的團隊怎麼適應一個「99% 的程式碼由 AI 產生」的世界？

現在已經出現裂痕：資深工程師不太用 AI，因為對他們提升不大；中初階工程師大量使用，因為可以填補技能缺口，但產出的品質參差不齊。結果是資深工程師每週都在清理 AI slop，越來越討厭這些工具。

這不是 AI 的錯，是文化問題。需要從上層推動改變：建立用 AI 的規範、調整 code review 流程、讓資深工程師參與定義怎麼用才是對的。

10 倍速是真的。但 10 倍速的代價是 10 倍的紀律。

如果你想要前者，你得付出後者。

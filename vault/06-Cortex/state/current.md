---
updated: 2026-06-17
---

# Cortex State

## 目前狀態
- 身份：遊戲 SaaS 產品經理（豪旺角 line-platform）
- 上次 session：2026-06-17，玩家客端字級大小規範討論

## 進行中的專案
- line-platform（Vue 3 + C#，單一租戶 LINE 娛樂城平台）

## 本次完成
- 討論玩家客端字級不一致問題，釐清處理方向：
  - 前端使用 px 單位 + Breakpoint 分段方式控制字級
  - 美術使用 Figma，請美術建立 Text Styles（各斷點各一套）
  - 確認最小字級為 12px（符合 WCAG 門檻）
  - 美術已在進行中，等待交稿

## 下次繼續
- 美術 Figma Text Styles 完成後，審查規格是否完整（需含字級、行高、字重）
- 確認前端斷點尺寸與美術設計稿尺寸是否對齊
- 實作 Stop hook（寫回流程自動化）：每次 Claude 停止後自動 sync 暫存檔至 GitHub
- 紅點規格書 §8 問題 #3（即時性方案）待 RD 回覆
- 紅點規格書 §8 問題 #4（聊天室初始未讀 fallback 行為）待聊天室 RD 確認
- 評估 Atlassian MCP 整合：規格書寫完後自動建 Jira ticket
- 全域 CLAUDE.md 其他問題待修：「描述功能需求」觸發條件太模糊、專案路徑已過時

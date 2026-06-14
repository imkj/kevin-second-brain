---
updated: 2026-06-14
---

# Cortex State

## 目前狀態
- 身份：遊戲 SaaS 產品經理（豪旺角 line-platform）
- 上次 session：2026-06-14，完成 second-brain GitHub API 架構設定

## 進行中的專案
- line-platform（Vue 3 + C#，單一租戶 LINE 娛樂城平台）

## 本次完成
- 分析 Claude Fable 5 文章（14 步驟自我改進 agent 系統）
- 診斷 pm-workspace 和 second-brain-template 兩個 repo 與文章的對齊度
- 移除 git config 中外洩的舊 GitHub token，改用 Git Credential Manager
- 撤銷舊 token，建立新 token 存至 C:\Users\kevin\.github_token
- 設定明天 09:00 提醒（其他兩台電腦設定 token）
- 建立 second-brain GitHub API 讀寫架構：
  - 更新 CLAUDE.md 啟動流程（改用 GitHub API 讀取狀態）
  - 新增 scripts/brain-write.sh（寫回腳本）
  - 更新 current.md 和 open-loops.md 狀態檔
- 研究 LLM Wiki（nashsu/llm_wiki），了解 MCP Server + Agent Skill 整合方式

## 下次繼續
- 在 Windows 和 Mac 兩台電腦設定 token（提醒已排 2026-06-15 09:00）
- 考慮是否借鑒 LLM Wiki 的搜尋式 skill 設計改善 wiki 查詢方式

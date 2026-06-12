# Second Brain — 讓 Claude Code 變成你的第二大腦

[English](README.md) | **繁體中文**

> 讓 Claude Code 不再是用完就忘的工具，而是一個會記住你、跟你一起成長的 AI 夥伴。

## 這是什麼？

一個框架，把 Claude Code CLI 從「每次都要重新教」的助手，變成一個**有記憶、有狀態、能跨平台溝通**的 AI 第二大腦。

它能做到：

- **記得你是誰** — 你的偏好、專業、說話方式，不用每次重講
- **接續上次的工作** — 上次做到哪、待辦事項、還沒解決的問題，它都知道
- **多通道溝通** — Terminal、Telegram、LINE，隨時隨地跟你的 AI 對話
- **越用越聰明** — 你糾正它一次，它記住一輩子
- **有全局觀** — 追蹤你的目標、找出缺口、主動提醒你該做什麼

## 架構

```
second-brain/
├── scripts/
│   └── wakeup.sh                 # 喚醒腳本（每次對話開始自動執行）
│
├── vault/                         # 知識庫（相容 Obsidian）
│   ├── 00-Inbox/                  # Session Log、待整理的東西
│   ├── 02-SOPs/                   # 標準作業流程
│   ├── 03-Projects/               # 進行中的專案
│   ├── 04-Resources/
│   │   └── Claude-Memory/         # AI 記憶系統
│   │       ├── MEMORY.md          # 主索引（每次都會載入）
│   │       ├── MEMORY-projects.md # 專案記憶索引
│   │       ├── MEMORY-feedback.md # 行為規則索引
│   │       ├── MEMORY-references.md # 參考資料索引
│   │       └── MEMORY-user.md     # 用戶資料索引
│   ├── 06-Cortex/                 # AI 狀態機
│   │   ├── state/
│   │   │   ├── current.md         # 目前狀態
│   │   │   └── open-loops.md      # 追蹤中的事項
│   │   └── strategic-loop.md      # 全局優先級與缺口
│   └── CLAUDE.md                  # 啟動協議
│
├── skills/                        # 可重複使用的 AI 技能模組
│   └── examples/
│       ├── save-session/SKILL.md  # Session 存檔
│       └── morning-standup/SKILL.md # 每日站會
│
├── daemon/                        # 常駐服務（選配）
│   ├── server.js                  # Express 伺服器
│   ├── daemon.js                  # Claude CLI 包裝器
│   └── ecosystem.config.js        # PM2 設定
│
└── CLAUDE.md                      # 根目錄啟動協議
```

## 核心概念

### 1. 啟動協議（`CLAUDE.md`）

每次開始對話，AI 會自動執行初始化：

```
1. 喚醒    → 收集上下文（時間、狀態、記憶、最近的 log）
2. 深度載入 → 根據任務讀取相關記憶
3. 套用規則 → 載入你教過它的行為準則
4. 結束時   → 更新狀態、儲存記憶、寫 session log
```

### 2. 記憶系統

四種記憶，各司其職：

| 類型 | 用途 | 範例 |
|------|------|------|
| `user` | 你是誰、你的偏好 | 「資深後端工程師，第一次碰 React」 |
| `feedback` | 該做 / 不該做的事 | 「整合測試不要 mock 資料庫」 |
| `project` | 進行中的工作 | 「Sprint 4 週五截止，還有 3 個任務」 |
| `reference` | 去哪裡找東西 | 「API Key 在 Vault 裡，不在 .env」 |

每條記憶是一個獨立的 `.md` 檔案：

```markdown
---
name: 整合測試不能用 mock
description: 測試要打真的資料庫，不能用 mock
type: feedback
---

整合測試必須連接真實資料庫。

**Why:** 上次 mock 測試全過，結果 prod 資料庫 migration 爆了。
**How to apply:** 碰到 DB 層的測試檔案時，確認是打真的 DB。
```

### 3. Cortex（狀態機）

追蹤 AI 跨 session 的意識狀態：

- **`current.md`** — 上次 session 在做什麼？目前的脈絡是什麼？
- **`open-loops.md`** — 你提過但還沒解決的事（AI 會主動追蹤）
- **`strategic-loop.md`** — 全局健康度：哪些做得好、哪些需要注意

### 4. 喚醒腳本

一個 shell script，收集所有恢復工作所需的上下文：

```bash
#!/bin/bash
# 輸出：當前時間、機器資訊、Cortex 狀態、
# 記憶索引、最近的 session log
```

### 5. Daemon（選配）

一個 Node.js 常駐服務：
- 讓 Claude CLI 持續運作
- 從 Telegram / LINE 接收訊息，轉給 Claude 處理
- 用 `--resume` 管理 session 連續性
- 佇列處理並發請求

## 快速開始

### 1. Clone 下來

```bash
git clone https://github.com/silmoontravis/second-brain-template.git my-second-brain
cd my-second-brain
```

### 2. 自訂啟動協議

打開 `CLAUDE.md`，改成你的設定：
- 喚醒腳本的路徑
- 知識庫的路徑
- 你的行為準則

### 3. 初始化知識庫

```bash
cd vault
# 編輯 06-Cortex/state/current.md，寫入你的初始狀態
# 編輯 04-Resources/Claude-Memory/MEMORY.md，建立空索引
```

### 4. 開始使用

```bash
claude  # Claude Code CLI 會自動讀 CLAUDE.md 並啟動
```

## 記憶管理

### 新增記憶

AI 學到新東西時會自動儲存。你也可以直接說：
- 「記住我偏好用 TypeScript」
- 「存起來：部署前一定要先上 UAT」

### 記憶索引

`MEMORY.md` 是主索引，每次對話都會載入。控制在 200 行以內。每一條指向一個詳細的記憶檔案。

### 記憶清理

- 跟現有程式碼矛盾的記憶要更新或刪除
- 不要重複儲存程式碼裡已經有的東西
- 儲存時把相對日期轉成絕對日期（「下週四」→「2026-06-19」）

## 多通道設定（選配）

### Telegram

用 Claude Code 的 Telegram plugin：
1. 在 @BotFather 建一個 bot
2. 設定 plugin 的 bot token
3. 完成，AI 可以收發 Telegram 訊息了

### LINE Bot

用 daemon 服務：
1. 在 LINE Developers 建立 Messaging API channel
2. 把 webhook URL 指向你的 daemon
3. daemon 會把 LINE 訊息轉給 Claude 處理

## 設計原則

1. **不要問，自己找** — AI 先查記憶和檔案，不要什麼都問你
2. **做完自己 QA** — 驗證了再回報，不讓你抓 bug
3. **小改快做，大改先規劃** — 簡單的直接做，複雜的先出計畫
4. **機密不進公開 repo** — 密碼放記憶 reference，不放程式碼
5. **時間用系統指令確認** — 不要自己猜日期

## 技能系統（Skills）

技能是可重複使用的指令模組 — AI 可以根據觸發詞啟動的專業工作流。

```
skills/
├── examples/
│   ├── save-session/SKILL.md    # 自動存檔 session 進度
│   └── morning-standup/SKILL.md # 每日站會摘要
└── （你的自訂技能放這裡）
```

每個技能是一個 `SKILL.md` 檔案，包含觸發詞和分步指令。完整寫法看 [docs/skills-system.md](docs/skills-system.md)。

**技能分類：**
- **工作流** — 部署、存檔、Code Review
- **知識型** — 後端工程、QA 自動化、SEO
- **訓練型** — 給團隊用的互動學習模組
- **創作型** — 文案、簡報、品牌語氣

## 沒有包含的東西

這個 template 故意排除了：
- 情感智慧模組（專利技術）
- 個人記憶內容
- API 金鑰和密碼
- 特定專案資料

## 授權

MIT — 拿去用、改、做你自己的版本。

## 作者

[Travis Chen](https://www.instagram.com/travis.ai.engineer/) — AI 工程師，做讓 AI 真正有用的工具。

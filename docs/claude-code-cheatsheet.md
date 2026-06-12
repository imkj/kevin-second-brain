# Claude Code 實用指令速查表

> 按使用頻率排列，從「每天都在用」到「偶爾需要」。

---

## 每天都在用

### 啟動與續接
| 指令 | 說明 |
|------|------|
| `claude` | 啟動新對話 |
| `claude -c` | 接續上一次對話（同目錄） |
| `claude -r "session名"` | 指定恢復某個 session |
| `claude "你的問題"` | 帶著問題直接開對話 |
| `claude -p "問題"` | 問完就退出（不進入互動模式） |

### 對話中常用
| 指令 / 快捷鍵 | 說明 |
|---------------|------|
| `Esc` | 中斷 AI 回應 |
| `Ctrl+C` | 中斷 / 清空輸入（按兩次退出） |
| `Ctrl+D` | 退出對話 |
| `/compact` | 壓縮對話，釋放 context 空間 |
| `/clear` | 清空對話，重新開始 |
| `Shift+Tab` | 切換權限模式（default → auto → plan） |

### 多行輸入
| 方式 | 說明 |
|------|------|
| `\` + `Enter` | 換行繼續輸入（所有終端都適用） |
| `Shift+Enter` | 換行（iTerm2/Windows Terminal 等） |
| `Ctrl+J` | 換行（任何終端都適用） |
| `Ctrl+G` | 打開外部編輯器寫長文 |

---

## 經常用到

### 模型與效能
| 指令 / 快捷鍵 | 說明 |
|---------------|------|
| `/model` 或 `Alt+P` | 切換模型（opus/sonnet/haiku） |
| `/fast` | 切換快速模式（同模型，更快輸出） |
| `/effort` | 設定思考深度（low/medium/high） |
| `Alt+T` | 開關延伸思考（Extended Thinking） |
| `Alt+O` | 開關快速模式 |

### 檔案與上下文
| 指令 | 說明 |
|------|------|
| `@檔名` | 在輸入框引用檔案 |
| `/add-dir 路徑` | 加入額外工作目錄 |
| `/context` | 視覺化 context 使用量 |
| `Ctrl+V` | 貼上剪貼簿圖片 |

### Code Review
| 指令 | 說明 |
|------|------|
| `/code-review` | 審查 diff，找 bug 和可改善處 |
| `/code-review --fix` | 審查 + 自動修復 |
| `/simplify` | 檢查程式碼有沒有可以簡化的地方 |
| `/diff` | 打開互動式 diff 檢視器 |

### Session 管理
| 指令 | 說明 |
|------|------|
| `/resume` | 顯示 session 選擇器，恢復對話 |
| `/branch 名稱` | 在這個點建立對話分支 |
| `/rename 名稱` | 重命名這個 session |
| `/export` | 匯出對話為純文字 |
| `/copy` | 複製上一個回應到剪貼簿 |

---

## 進階功能

### 背景執行
| 指令 / 快捷鍵 | 說明 |
|---------------|------|
| `Ctrl+B` | 把目前工作丟到背景 |
| `claude --bg "任務"` | 直接在背景啟動 agent |
| `claude agents` | 開啟 agent 監控面板 |
| `claude attach ID` | 接入背景 session |
| `claude stop ID` | 停止背景 session |
| `/tasks` | 查看背景任務 |
| `Ctrl+T` | 開關任務列表 |

### 批次與排程
| 指令 | 說明 |
|------|------|
| `/batch "指令"` | 平行處理大量變更 |
| `/loop 5m /指令` | 每 5 分鐘重複執行 |
| `/schedule` | 建立雲端排程任務 |
| `/goal "條件"` | 設定目標，AI 自動朝目標工作 |

### 規劃與審查
| 指令 | 說明 |
|------|------|
| `/plan` | 進入規劃模式 |
| `/review PR` | 審查 Pull Request |
| `/ultrareview PR` | 深度多 agent 雲端審查 |
| `/ultraplan "描述"` | 雲端規劃 + 執行 |
| `/deep-research "問題"` | 深度網路研究 |

### Git Worktree
| 指令 | 說明 |
|------|------|
| `claude -w 名稱` | 在隔離的 git worktree 開 session |
| `/rewind` | 回滾到上一個 checkpoint |

### 權限管理
| 指令 | 說明 |
|------|------|
| `/permissions` | 管理 allow/ask/deny 規則 |
| `/fewer-permission-prompts` | 分析對話，自動加入白名單 |

---

## 設定與維護

### 設定
| 指令 | 說明 |
|------|------|
| `/config` | 打開設定介面 |
| `/memory` | 管理 CLAUDE.md 和自動記憶 |
| `/init` | 初始化專案（建立 CLAUDE.md） |
| `/theme` | 換主題 |
| `/keybindings` | 自訂快捷鍵 |
| `/statusline` | 設定狀態列 |

### MCP 伺服器
| 指令 | 說明 |
|------|------|
| `/mcp` | 管理 MCP 連線 |
| `/mcp reconnect` | 重新連線 |
| `claude mcp` | CLI 管理 MCP |

### 診斷
| 指令 | 說明 |
|------|------|
| `/doctor` | 診斷安裝問題 |
| `/debug` | 開啟 debug 模式 |
| `/status` | 顯示版本、模型、連線狀態 |
| `/usage` | 顯示本次費用和用量 |
| `/hooks` | 查看 hook 設定 |

### 帳號
| 指令 | 說明 |
|------|------|
| `claude auth login` | 登入 |
| `claude auth logout` | 登出 |
| `claude auth status` | 查看帳號狀態 |
| `claude update` | 更新 Claude Code |

---

## CLI 常用參數

```bash
# 指定模型
claude --model sonnet

# 自動模式（不問權限）
claude --permission-mode auto

# 限制預算
claude --max-budget-usd 5

# 限制回合數
claude --max-turns 10

# 自訂系統提示
claude --append-system-prompt "Always respond in Traditional Chinese"

# 管道輸入
cat error.log | claude -p "分析這個錯誤"
git diff | claude -p "review 這些變更"
```

---

## 重要設定檔位置

```
~/.claude/
├── settings.json         # 全域設定（模型、權限、hooks）
├── keybindings.json     # 快捷鍵
├── skills/              # 全域技能
└── projects/            # 專案記憶

.claude/                  # 專案層級
├── CLAUDE.md            # 專案指令
├── settings.json        # 專案設定
├── settings.local.json  # 本機覆蓋（不進 git）
└── skills/              # 專案技能
```

---

## 每日工作流建議

```
1. claude -c              ← 接續昨天的對話
2. (AI 自動喚醒，讀取狀態)
3. 做事...
4. /compact               ← context 快滿時壓縮
5. /compact               ← 可以多次壓縮
6. 「存檔」               ← 觸發 save-session 技能
7. Ctrl+D                 ← 結束
```

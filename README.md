# claude-skills

Claude Code 專用技能集合與環境安裝腳本。

## 內容

| 檔案 | 類型 | 說明 |
|------|------|------|
| `skills/caveman.md` | Skill | Ultra-compressed 溝通模式，節省 ~75% token |
| `skills/find-skills.md` | Skill | 搜尋、安裝、管理 AI Agent Skills |
| `skills/pollinations.md` | Skill | 免費 AI 圖片生成，無需 API key（Pollinations.ai）|
| `setup.sh` | 腳本 | Claude Code 環境一鍵安裝 |

---

## skills/caveman

讓 Claude Code 像聰明穴居人說話——砍掉所有廢話，保留全部技術內容。

**觸發時機：** 使用者說「caveman mode」、「talk like caveman」、「less tokens」、「be brief」或輸入 `/caveman`。

### 強度等級

| 等級 | 說明 |
|------|------|
| `lite` | 去除廢話/對沖語氣，保留完整句子與冠詞 |
| `full`（預設）| 省略冠詞，可用片段，短同義詞替換 |
| `ultra` | 縮寫常見詞（DB/auth/req/res），去結合詞，用箭頭表因果 |
| `wenyan-lite` | 半文言文，去廢話但保留語法結構 |
| `wenyan-full` | 完全文言文，節省 80-90% 字符 |
| `wenyan-ultra` | 極限壓縮文言文 |

**切換指令：**
```
/caveman lite     # 輕量模式
/caveman full     # 完整模式（預設）
/caveman ultra    # 極致壓縮
stop caveman      # 關閉，回到正常模式
normal mode       # 同上
```

### 範例對比

**問：** "Why React component re-render?"

| 等級 | 回應 |
|------|------|
| **正常** | "Your component re-renders because you create a new object reference each render. Wrap it in `useMemo`." |
| **lite** | "Your component re-renders because you create a new object reference each render. Wrap it in `useMemo`." |
| **full** | "New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`." |
| **ultra** | "Inline obj prop → new ref → re-render. `useMemo`." |
| **wenyan-full** | "物出新參照，致重繪。`useMemo` 包之。" |

### 不適用場合

以下情況自動切換回正常語氣：
- 安全性警告
- 不可逆操作確認
- 多步驟順序敏感的指令
- 壓縮後技術語意不清時
- 使用者要求澄清

完成後自動恢復 caveman 模式。

### 永久規則
- 程式碼區塊、commit 訊息、PR 內容：永遠正常書寫
- 技術術語（函數名稱、API、錯誤訊息）：永不縮寫
- 模式在整個 session 中持續，不自動回覆

---

## skills/find-skills

搜尋、安裝、管理 AI Agent Skills 生態系（來源：[vercel-labs/skills](https://github.com/vercel-labs/skills)）。

**觸發時機：** 使用者說「find a skill for X」、「is there a skill for X」、「how do I do X」、或想擴充 Agent 功能時。

### 核心功能

使用 `npx skills` CLI 管理跨 Agent 的 Skills 套件：

```bash
# 搜尋 skills
npx skills find [查詢關鍵字]

# 安裝 skill
npx skills add <owner/repo> -g -y

# 檢查更新
npx skills check

# 更新全部
npx skills update
```

### 推薦流程

1. 先查 [skills.sh leaderboard](https://skills.sh/) — 看有無高安裝量的現成 skill
2. 若無，執行 `npx skills find [關鍵字]` 搜尋
3. 驗證品質：1K+ 安裝量、來源可信（vercel-labs / anthropics / microsoft）
4. 提供安裝指令給使用者

### 常用分類關鍵字

| 類別 | 關鍵字 |
|------|--------|
| 前端 | `react`, `nextjs`, `typescript`, `tailwind` |
| 測試 | `testing`, `jest`, `playwright` |
| DevOps | `deploy`, `docker`, `kubernetes` |
| 文件 | `docs`, `readme`, `changelog` |
| 程式碼品質 | `review`, `lint`, `refactor` |

### 找不到時

直接用 Agent 原有能力處理，或建議使用者自建：
```bash
npx skills init my-skill-name
```

---

## setup.sh

Claude Code 環境一鍵安裝腳本。

**執行：**
```bash
bash setup.sh
```

**安裝內容：**
1. 檢查 Node.js 與 npm
2. 安裝 Claude Code CLI（`@anthropic-ai/claude-code`）
3. 安裝官方插件：`anthropics/claude-plugins-official`（包含 superpowers）
4. 安裝社群插件：`ComposioHQ/awesome-claude-skills`

**前置需求：**
- Node.js（任意版本）
- npm
- 網路連線

**輸出範例：**
```
==============================
 Claude Code Environment Setup
==============================

[✓] Node.js v20.11.0
[✓] npm 10.2.4
[…] Installing Claude Code CLI...
[✓] Claude Code installed: 1.x.x
[…] Installing superpowers...
[✓] superpowers installed
[…] Installing awesome-claude-skills...
[✓] awesome-claude-skills installed

==============================
[✓] Setup complete! Run: claude
==============================
```

---

## 安裝 Skills

```bash
# 安裝全部 skills 到 Claude Code
npx skills add taiynlee/claude-skills -a claude-code

# 或用 claude plugins
claude plugins add taiynlee/claude-skills
```

安裝後：
- `/caveman` 啟用壓縮模式
- `find a skill for X` 自動觸發 find-skills

---

## skills/pollinations

免費 AI 圖片生成，使用 [Pollinations.ai](https://pollinations.ai) API。無需帳號、無需 API key、無限制生成。

**觸發時機：** 生成圖片、AI 作圖、text-to-image、免費圖片 AI。

### 快速使用（PowerShell）

```powershell
$prompt = "your description here"
$encoded = [System.Uri]::EscapeDataString($prompt)
$url = "https://image.pollinations.ai/prompt/$encoded?width=1280&height=720&model=flux&seed=42&nologo=true"
Invoke-WebRequest -Uri $url -OutFile "$env:USERPROFILE\Downloads\output.jpg" -TimeoutSec 120
```

### 常用模型

| 模型 | 特性 |
|------|------|
| `flux`（預設）| 高品質通用 |
| `flux-realism` | 寫實風格 |
| `flux-anime` | 動漫風格 |
| `turbo` | 速度優先 |
| `sana` | 新一代模型 |
| `kontext` | 圖生圖 |

### 常用解析度

| 用途 | 寬 x 高 |
|------|---------|
| 橫幅 16:9 | 1280 x 720 |
| 方形 | 1024 x 1024 |
| 手機直幅 | 720 x 1280 |

生成時間 10–30 秒，免費無限制。

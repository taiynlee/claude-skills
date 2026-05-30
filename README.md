# claude-skills

Claude Code 專用技能集合與環境安裝腳本。目前收錄 **caveman** 溝通模式技能，大幅壓縮 token 用量，同時保留完整技術精確度。

## 內容

| 檔案 | 類型 | 說明 |
|------|------|------|
| `skills/caveman.md` | Skill | Ultra-compressed 溝通模式，節省 ~75% token |
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
# 安裝 caveman skill 到 Claude Code
claude plugins add taiynlee/claude-skills

# 或使用 npx skills
npx skills add taiynlee/claude-skills -a claude-code
```

安裝後，在 Claude Code 對話中輸入 `/caveman` 即可啟用。

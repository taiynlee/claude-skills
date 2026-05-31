---
name: pollinations
description: >
  免費 AI 圖片生成工具，使用 Pollinations.ai API。無需 API key、無需註冊、無需付費，
  直接透過 HTTP 請求生成圖片。觸發時機：用戶要求生成圖片、AI 作圖、文字轉圖片、
  圖片生成、免費圖片 AI，或任何 text-to-image 相關需求。
---

# Pollinations 圖片生成 Skill

免費、無需帳號的 AI 圖片生成，基於 [Pollinations.ai](https://pollinations.ai)。

## 特點

- 完全免費，無需 API key 或帳號
- 支援多種 AI 模型（Flux、Sana、Turbo 等）
- 支援多種解析度與長寬比
- 無限制生成次數

## API 端點

```
GET https://image.pollinations.ai/prompt/{prompt}
```

## 參數

| 參數 | 說明 | 預設 | 範例 |
|------|------|------|------|
| `prompt` | 圖片描述（URL encode）| 必填 | `cyberpunk city` |
| `model` | 模型選擇 | `flux` | `flux`, `turbo`, `sana` |
| `width` | 寬度（像素）| 1024 | `1280` |
| `height` | 高度（像素）| 1024 | `720` |
| `seed` | 固定種子（可重現）| 隨機 | `42` |
| `nologo` | 移除浮水印 | `false` | `true` |
| `enhance` | AI 自動強化 prompt | `false` | `true` |
| `private` | 不公開在 feed | `false` | `true` |

## 可用模型

| 模型 | 特性 |
|------|------|
| `flux`（預設）| 高品質通用，最常用 |
| `flux-realism` | 寫實風格 |
| `flux-anime` | 動漫風格 |
| `flux-3d` | 3D 立體感 |
| `turbo` | 速度優先（較快） |
| `sana` | 新一代模型 |
| `any-dark` | 暗色主題 |
| `kontext` | 圖生圖（需傳入圖片 URL） |

取得最新模型清單：
```bash
curl https://image.pollinations.ai/models
```

## 常用長寬比

| 用途 | 寬 x 高 |
|------|---------|
| 方形（社群）| 1024 x 1024 |
| 橫幅 16:9 | 1280 x 720 |
| 直幅 9:16（手機）| 720 x 1280 |
| 橫幅 4:3 | 1024 x 768 |
| 超寬 21:9 | 1920 x 820 |

## 執行方式

### PowerShell（Windows）

```powershell
$prompt = "your image description here"
$encoded = [System.Uri]::EscapeDataString($prompt)
$url = "https://image.pollinations.ai/prompt/$encoded?width=1280&height=720&model=flux&seed=42&nologo=true"
$output = "$env:USERPROFILE\Downloads\output.jpg"
Invoke-WebRequest -Uri $url -OutFile $output -TimeoutSec 120
Write-Output "Saved: $output"
```

### Bash / WSL

```bash
PROMPT="your image description here"
ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$PROMPT'))")
curl -o ~/Downloads/output.jpg \
  "https://image.pollinations.ai/prompt/$ENCODED?width=1280&height=720&model=flux&seed=42&nologo=true"
```

### Python

```python
import requests
from urllib.parse import quote

prompt = "your image description here"
url = f"https://image.pollinations.ai/prompt/{quote(prompt)}"
params = {
    "width": 1280,
    "height": 720,
    "model": "flux",
    "seed": 42,
    "nologo": "true"
}
response = requests.get(url, params=params, timeout=120)
with open("output.jpg", "wb") as f:
    f.write(response.content)
```

## Prompt 技巧

**公式：** `主體 + 環境/場景 + 風格 + 技術細節`

```
# 科技感商業圖
futuristic dashboard with holographic displays, neon blue circuit patterns,
dark background, cinematic lighting, 16:9, ultra-sharp

# 產品展示
minimalist product shot, soft studio lighting, white background,
professional e-commerce, clean composition

# 動漫風格（搭配 flux-anime）
anime girl with blue hair, cherry blossom background,
soft lighting, Studio Ghibli style
```

**要避免的：**
- 衝突風格（minimalist + ornate + cyberpunk 同時）
- 過長 prompt（200 字以內效果最好）
- 對特定人臉的精確描述（模型不穩定）

## 圖生圖（kontext 模型）

```powershell
$inputImageUrl = "https://example.com/input.jpg"
$prompt = "change background to space"
$encoded = [System.Uri]::EscapeDataString($prompt)
$url = "https://image.pollinations.ai/prompt/$encoded?model=kontext&image=$inputImageUrl"
Invoke-WebRequest -Uri $url -OutFile output.jpg -TimeoutSec 120
```

## 注意事項

- 生成時間通常 10–30 秒，複雜圖像可能更長
- 免費版圖片可能出現在 Pollinations 公開 feed（加 `private=true` 可隱藏）
- 無法生成特定真實人物的臉
- 每次不帶 seed 會產生不同結果；固定 seed 可重現相同構圖

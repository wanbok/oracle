# oracle

Công cụ xác minh chéo mô hình cho [Claude Code](https://claude.com/claude-code). Kết nối Claude với [Codex (GPT-5.3)](https://github.com/openai/codex) để nhận ý kiến thứ hai về code review, triển khai thay thế và xác nhận kiến trúc.

[한국어](README.md) | [English](README.en.md) | [日本語](README.ja.md)

## Tại sao cần?

Mỗi mô hình AI có điểm mạnh và điểm mù khác nhau. Khi nhờ mô hình thứ hai review code, bạn có thể phát hiện các vấn đề mà một mô hình đơn lẻ có thể bỏ sót. Oracle tự động hóa quy trình xác minh chéo này.

## Yêu cầu

- [Claude Code](https://claude.com/claude-code) đã cài đặt
- [Codex CLI](https://github.com/openai/codex) đã cài đặt + cấu hình OpenAI API key

```bash
npm install -g @openai/codex
```

## Cài đặt

### Cách A: Plugin (khuyến nghị)

Cài đặt qua [hệ thống plugin Claude Code](https://docs.anthropic.com/en/docs/claude-code/plugins). Sử dụng được `/oracle:ask`.

```bash
# Thêm marketplace
/plugin marketplace add wanbok/claude-marketplace

# Cài đặt plugin
/plugin install oracle@wanbok-claude-marketplace
```

### Cách B: Cài đặt bằng script

Clone repo và chạy script cài đặt. Sử dụng được `/oracle` skill + `oracle` agent.

```bash
git clone https://github.com/wanbok/oracle.git
cd oracle
chmod +x install.sh
./install.sh
```

Cài đặt agent vào `~/.claude/agents/` và skill vào `~/.claude/skills/` bằng symbolic link.

> **Lưu ý:** Chỉ chọn một phương pháp cài đặt. Nếu oracle plugin (Cách A) đã được cài, namespace `oracle` sẽ bị plugin chiếm giữ, khiến `/oracle` local skill từ Cách B không được nhận diện. Plugin dùng `/oracle:ask`, script dùng `/oracle` — không hỗ trợ cài đồng thời.

## Cách sử dụng

### Sử dụng như Skill

```
/oracle Review edge case của hàm này
/oracle:ask Review edge case của hàm này   # khi cài bằng plugin
```

Cả hai đều thực thi cùng một quy trình 5 bước: phân tích → thu thập context → gọi Codex → kiểm tra chất lượng → báo cáo.

### Sử dụng như Custom Agent

Chỉ định `oracle` làm `subagent_type` trong Task tool:

```
Task(subagent_type="oracle", prompt="Review vấn đề bảo mật của code này: ...")
```

### Sử dụng như Team Role

Thêm role `oracle` vào agent team để thực hiện xác minh chéo mô hình liên tục trong quá trình phát triển. Xem [examples/team-usage.md](examples/team-usage.md).

## Cách hoạt động

```
Nhập câu hỏi
   │
   ▼
Oracle đọc code
liên quan (Read/Grep)
   │
   ▼
Tạo prompt với
inline code context
   │
   ▼
Gửi đến Codex CLI
(timeout: 180 giây)
   │
   ▼
Kiểm tra chất lượng
phản hồi của Codex
   │
   ▼
Báo cáo kết quả
đã xác minh
```

Oracle là **chỉ đọc** — không chỉnh sửa file. Chỉ đề xuất, quyết định áp dụng là của bạn.

## Cấu hình Backend

Mặc định sử dụng [Codex CLI](https://github.com/openai/codex), nhưng có thể thay đổi backend bằng cách sửa lệnh `codex exec` trong `agents/oracle.md`.

| Backend | Lệnh | Ghi chú |
|---------|------|---------|
| **Codex CLI** (mặc định) | `codex exec "prompt"` | Cần OpenAI API key |
| **Ollama** | `ollama run llama3 "prompt"` | Chạy local, miễn phí, không cần API key |
| **OpenRouter** | `curl` đến OpenRouter API | Đa mô hình, trả theo lượt |
| **Google Gemini** | `gemini "prompt"` | Cần Google AI API key |

Để thay đổi backend, thay thế pattern `codex exec` trong phần "How to Call Codex" của `agents/oracle.md`.

## Gỡ cài đặt

```bash
./uninstall.sh
```

## Giấy phép

MIT

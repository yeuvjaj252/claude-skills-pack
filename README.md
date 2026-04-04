# Claude Skills Pack

Bộ commands, agents và skills cho Claude Code.

## Cài đặt

### Linux/macOS

```bash
git clone https://github.com/yeuvjaj252/claude-skills-pack.git
cd claude-skills-pack
./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/yeuvjaj252/claude-skills-pack.git
cd claude-skills-pack
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

## Gỡ cài đặt

### Linux/macOS

```bash
./uninstall.sh
```

### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
```

## Cập nhật

### Linux/macOS

```bash
./update.sh
```

### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File .\update.ps1
```

> Ghi chú: script update sẽ thử đồng bộ source mới nhất từ GitHub (`git pull --ff-only`) nếu thư mục hiện tại là git clone có `origin`. Nếu không pull được (local changes/network), script sẽ tiếp tục update bằng source local hiện có.

### Migration nhanh

- `/plan` -> `/csp-plan`
- `/create` -> `/cook`
- Các command còn lại chuyển sang namespace `/csp-*`

## Nội dung

| Thành phần | Số lượng | Namespace |
|------------|----------|-----------|
| Commands   | 22 files | `/csp-*`, `/cook` |
| Agents     | 20 files | — |
| Skills     | 49 folders | `skill-csp-*` |

> **Namespace:** Tất cả skills đều có prefix `skill-csp-` để tránh xung đột khi dùng chung với các plugin khác (ví dụ: Superpowers). Commands dùng prefix `/csp-*`.

## Tương thích với Superpowers plugin

CSP được thiết kế để chạy song song với [Superpowers](https://github.com/obra/superpowers) mà không xung đột:

| | CSP | Superpowers |
|---|---|---|
| Skills | `skill-csp-*` | `superpowers:*` |
| Commands | `/csp-*`, `/cook` | `/brainstorm`, `/execute-plan`, `/write-plan` |
| Agents | 20 agents | `code-reviewer` |

## Skills nội bộ mới

### `skill-csp-context7-research`

Utility skill để tra cứu docs chính thức qua Context7 khi plan hoặc implementation phụ thuộc vào framework/library cụ thể.

Skill này nên được dùng khi:
- task có nhắc rõ tên framework, package, SDK hoặc library
- config, migration, setup, hoặc API cần đúng theo version
- user hỏi best practice chính thức
- có nguy cơ hallucinate nếu không tra docs

### Tích hợp đề xuất

- `/csp-research` là command chuyên để tra docs bằng Context7
- `/csp-plan` có thể dùng `skill-csp-context7-research` khi plan phụ thuộc framework convention hoặc version-specific behavior
- `/cook` có thể dùng `skill-csp-context7-research` khi implementation cần exact external API hoặc config syntax

### `skill-csp-prompt-leverage`

Skill hỗ trợ nội bộ để nâng chất lượng input trước khi agent lập kế hoạch hoặc thực thi.

Skill này không nhất thiết là command người dùng phải gọi trực tiếp. Thay vào đó, các command như `/csp-plan` có thể dùng nó nội bộ khi request:

- mơ hồ hoặc thiếu constraint → `clarify`
- dài nhưng thiếu cấu trúc → `structure`
- cần so sánh hướng đi trước khi plan → `brainstorm`
- đã rõ ràng và cần chuyển thành instruction thực thi → `execute`

### Tích hợp hiện tại

- `/csp-plan` sẽ ưu tiên dùng `skill-csp-prompt-leverage` như bước preflight khi input chưa đủ rõ để lập plan tốt.
- `/cook` dùng `skill-csp-prompt-leverage` để làm rõ app type, scope và chuẩn hóa request trước khi handoff sang planning/building.
- `/csp-brainstorm` dùng `skill-csp-prompt-leverage` để làm rõ context và tái cấu trúc input trước khi tạo các option A/B/C.
- `/csp-debug` dùng `skill-csp-prompt-leverage` để chuẩn hóa bug report trước khi đi vào giả thuyết và điều tra.
- `/csp-docs` dùng `skill-csp-prompt-leverage` để xác định audience, scope và loại tài liệu trước khi viết.

### Ghi chú sử dụng

- User vẫn nên gọi command cấp cao như `/csp-plan`
- `skill-csp-prompt-leverage` đóng vai trò utility skill phía sau
- Chỉ kích hoạt khi thật sự có lợi, không thêm ceremony cho task đơn giản

## Commands có sẵn (mô tả đầy đủ)

| Command | Description |
|---|---|
| `/csp-backend` | ⚙️ Kiến trúc backend Node.js/Python/serverless-edge: API, logic server, tích hợp DB, bảo mật. |
| `/csp-brainstorm` | 🧠 Brainstorm có cấu trúc, đưa nhiều hướng tiếp cận trước khi bắt đầu implement. |
| `/cook` | 👨‍🍳 Khởi tạo app mới, điều phối planner + các specialist để dựng dự án end-to-end. |
| `/csp-database` | 🗄️ Thiết kế schema, migration, query/index optimization, định hướng ORM/database strategy. |
| `/csp-debug` | 🐞 Debug có hệ thống theo giả thuyết, tìm root cause và đề xuất cách phòng ngừa tái diễn. |
| `/csp-deploy` | 🚀 Quy trình deploy production: pre-flight check, deploy, verify, rollback khi cần. |
| `/csp-devops` | 🛠️ Thiết lập CI/CD, Docker, hạ tầng và vận hành môi trường triển khai. |
| `/csp-docs` | 📝 Soạn/cập nhật tài liệu (README, API docs, technical docs) theo chuẩn rõ ràng, dễ dùng. |
| `/csp-research` | 🔎 Tra cứu docs framework/library bằng Context7 để giảm hallucination trước khi plan hoặc implement. |
| `/csp-enhance` | ✨ Nâng cấp tính năng trong dự án hiện có, triển khai theo hướng iterative development. |
| `/csp-explore` | 🧭 Khám phá codebase: cấu trúc, entry points, dependencies, data flow, pattern kiến trúc. |
| `/csp-frontend` | 🎨 Kiến trúc frontend React/Next.js: component, state, responsive UX, accessibility, hiệu năng. |
| `/csp-plan` | 📋 Lập kế hoạch implementation chi tiết (không code), breakdown task và dependency rõ ràng. |
| `/csp-mobile` | 📱 Phát triển mobile cross-platform (React Native/Flutter/Expo), tối ưu theo ngữ cảnh di động. |
| `/csp-orchestrate` | 🎼 Điều phối nhiều agent cho bài toán phức tạp cần nhiều góc nhìn chuyên môn. |
| `/csp-performance` | ⚡ Audit và tối ưu hiệu năng frontend/backend, theo dõi Core Web Vitals và bottlenecks. |
| `/csp-preview` | 👀 Quản lý preview server local: start/stop/restart/status/health check. |
| `/csp-security` | 🔒 Rà soát bảo mật theo best practices/OWASP, ưu tiên auth, input validation, hardening. |
| `/csp-status` | 📊 Hiển thị trạng thái dự án và tiến độ làm việc (project info, task status, preview status). |
| `/csp-test` | 🧪 Sinh test, chạy test, kiểm tra coverage cho unit/integration/E2E theo ngữ cảnh. |
| `/csp-ui` | 🎯 Thiết kế và triển khai UI/UX theo design system (style, color, typography, interaction). |
| `/csp-ui-ux-pro-max` | 🪄 Design intelligence nâng cao cho UI/UX với style, palette, typography và workflow đề xuất tự động. |

## Danh sách nhanh

`/csp-backend`, `/csp-brainstorm`, `/cook`, `/csp-database`, `/csp-debug`, `/csp-deploy`, `/csp-devops`, `/csp-docs`, `/csp-enhance`, `/csp-explore`, `/csp-frontend`, `/csp-plan`, `/csp-mobile`, `/csp-orchestrate`, `/csp-performance`, `/csp-preview`, `/csp-research`, `/csp-security`, `/csp-status`, `/csp-test`, `/csp-ui`, `/csp-ui-ux-pro-max`

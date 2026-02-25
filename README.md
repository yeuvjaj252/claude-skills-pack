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

| Thành phần | Số lượng |
|------------|----------|
| Commands   | 21 files |
| Agents     | 20 files |
| Skills     | 46 folders |

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

`/csp-backend`, `/csp-brainstorm`, `/cook`, `/csp-database`, `/csp-debug`, `/csp-deploy`, `/csp-devops`, `/csp-docs`, `/csp-enhance`, `/csp-explore`, `/csp-frontend`, `/csp-plan`, `/csp-mobile`, `/csp-orchestrate`, `/csp-performance`, `/csp-preview`, `/csp-security`, `/csp-status`, `/csp-test`, `/csp-ui`, `/csp-ui-ux-pro-max`

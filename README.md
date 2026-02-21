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

## Nội dung

| Thành phần | Số lượng |
|------------|----------|
| Commands   | 21 files |
| Agents     | 20 files |
| Skills     | 46 folders |

## Commands có sẵn (mô tả đầy đủ)

| Command | Description |
|---|---|
| `/backend` | Kiến trúc backend Node.js/Python/serverless-edge: API, logic server, tích hợp DB, bảo mật. |
| `/brainstorm` | Brainstorm có cấu trúc, đưa nhiều hướng tiếp cận trước khi bắt đầu implement. |
| `/create` | Khởi tạo app mới, điều phối planner + các specialist để dựng dự án end-to-end. |
| `/database` | Thiết kế schema, migration, query/index optimization, định hướng ORM/database strategy. |
| `/debug` | Debug có hệ thống theo giả thuyết, tìm root cause và đề xuất cách phòng ngừa tái diễn. |
| `/deploy` | Quy trình deploy production: pre-flight check, deploy, verify, rollback khi cần. |
| `/devops` | Thiết lập CI/CD, Docker, hạ tầng và vận hành môi trường triển khai. |
| `/docs` | Soạn/cập nhật tài liệu (README, API docs, technical docs) theo chuẩn rõ ràng, dễ dùng. |
| `/enhance` | Nâng cấp tính năng trong dự án hiện có, triển khai theo hướng iterative development. |
| `/explore` | Khám phá codebase: cấu trúc, entry points, dependencies, data flow, pattern kiến trúc. |
| `/frontend` | Kiến trúc frontend React/Next.js: component, state, responsive UX, accessibility, hiệu năng. |
| `/mobile` | Phát triển mobile cross-platform (React Native/Flutter/Expo), tối ưu theo ngữ cảnh di động. |
| `/orchestrate` | Điều phối nhiều agent cho bài toán phức tạp cần nhiều góc nhìn chuyên môn. |
| `/performance` | Audit và tối ưu hiệu năng frontend/backend, theo dõi Core Web Vitals và bottlenecks. |
| `/plan` | Lập kế hoạch implementation chi tiết (không code), breakdown task và dependency rõ ràng. |
| `/preview` | Quản lý preview server local: start/stop/restart/status/health check. |
| `/security` | Rà soát bảo mật theo best practices/OWASP, ưu tiên auth, input validation, hardening. |
| `/status` | Hiển thị trạng thái dự án và tiến độ làm việc (project info, task status, preview status). |
| `/test` | Sinh test, chạy test, kiểm tra coverage cho unit/integration/E2E theo ngữ cảnh. |
| `/ui` | Thiết kế và triển khai UI/UX theo design system (style, color, typography, interaction). |
| `/ui-ux-pro-max` | Design intelligence nâng cao cho UI/UX với style, palette, typography và workflow đề xuất tự động. |

## Danh sách nhanh

`/backend`, `/brainstorm`, `/create`, `/database`, `/debug`, `/deploy`, `/devops`, `/docs`, `/enhance`, `/explore`, `/frontend`, `/mobile`, `/orchestrate`, `/performance`, `/plan`, `/preview`, `/security`, `/status`, `/test`, `/ui`, `/ui-ux-pro-max`

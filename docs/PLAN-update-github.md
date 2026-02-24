# Kế hoạch: Cơ chế update có nên lấy từ GitHub?

## Overview
Mục tiêu của kế hoạch này là làm rõ câu hỏi: "phần update không phải update từ trên github à?" và chuẩn hóa cơ chế cập nhật cho dự án để tránh sai lệch giữa kỳ vọng người dùng và hành vi thực tế của script update.

Trọng tâm:
- Xác định update hiện tại lấy từ nguồn nào.
- So sánh các phương án cập nhật (GitHub pull, release artifact, package registry).
- Chốt một cơ chế chính + cơ chế fallback + rollback.

## Project Type
**BACKEND** (CLI/script vận hành cập nhật).

## Socratic Gate (Làm rõ mơ hồ trước khi triển khai)

### Câu hỏi 1: Nguồn cập nhật chính mong muốn là gì?
- Tại sao quan trọng: quyết định kiến trúc update, độ ổn định và bảo mật.
- Tùy chọn:
  - A. `git pull` trực tiếp từ GitHub repository.
  - B. Tải release artifact đã version hóa từ GitHub Releases.
  - C. Mirror nội bộ (không phụ thuộc trực tiếp GitHub).
- Mặc định nếu chưa trả lời: **B** (ổn định hơn cho người dùng cuối, dễ rollback theo version).

### Câu hỏi 2: Đối tượng sử dụng update là ai?
- Tại sao quan trọng: dev nội bộ và end-user cần luồng khác nhau.
- Tùy chọn:
  - A. Chỉ dev dùng git clone.
  - B. Người dùng phổ thông cài script rồi update một lệnh.
- Mặc định nếu chưa trả lời: **B**.

### Câu hỏi 3: Ưu tiên cao nhất là gì?
- Tại sao quan trọng: trade-off giữa nhanh, ổn định, và bảo mật.
- Tùy chọn:
  - A. Nhanh nhất: pull branch mới nhất.
  - B. Ổn định: chỉ update theo tag/release đã kiểm thử.
  - C. An toàn: có checksum/chữ ký + rollback tự động.
- Mặc định nếu chưa trả lời: **B + C**.

## Assumptions
1. Người dùng kỳ vọng update lấy từ GitHub (theo wording câu hỏi).
2. Dự án đang có script update trên Linux và Windows (`update.sh`, `update.ps1`).
3. Chưa có tài liệu rõ ràng về strategy update (branch-based hay release-based).
4. Không thực hiện code change trong giai đoạn này (chỉ lập kế hoạch).

## Alternatives (Phương án update)

### Phương án A: `git pull` từ GitHub
- Ưu điểm: đơn giản, ít bước.
- Nhược điểm: dễ bị thay đổi ngoài ý muốn nếu branch chính biến động.
- Phù hợp: đội dev nội bộ.

### Phương án B: GitHub Releases (artifact/tag)
- Ưu điểm: version rõ ràng, rollback tốt, tính tái lập cao.
- Nhược điểm: cần quy trình phát hành release.
- Phù hợp: người dùng phổ thông và môi trường production-like.

### Phương án C: Package registry/mirror nội bộ
- Ưu điểm: kiểm soát cao, giảm phụ thuộc GitHub runtime.
- Nhược điểm: tăng chi phí vận hành.
- Phù hợp: tổ chức có yêu cầu compliance cao.

## Quyết định đề xuất (Draft)
- Kênh mặc định: **GitHub Releases (B)**.
- Kênh dev/nhanh: tùy chọn `git pull` (A) cho nhánh dev.
- Bắt buộc có:
  - kiểm tra version hiện tại vs latest release,
  - checksum/signature (nếu khả thi),
  - rollback về bản trước khi update lỗi.

## Success Criteria (Acceptance Criteria)
1. Có tài liệu quyết định rõ: update từ GitHub theo cơ chế nào và khi nào dùng cơ chế nào.
2. Có ma trận quyết định cho 3 nhóm người dùng: dev, nội bộ, end-user.
3. Có định nghĩa rollback khi update thất bại.
4. Có checklist verify cho Linux + Windows.
5. Không còn mơ hồ về câu hỏi "update từ GitHub hay không" trong docs vận hành.

## Tech Stack (cho kế hoạch triển khai)
- **Git/GitHub API**: lấy thông tin tag/release/version.
- **Shell + PowerShell**: tương thích Linux/Windows update flow.
- **Checksum tool (sha256)**: xác thực artifact.
- **CI (GitHub Actions)**: tự động phát hành release + metadata.

Lý do chọn: đồng bộ với hiện trạng repo có `update.sh` và `update.ps1`, giảm thay đổi công nghệ.

## File Structure (dự kiến, chưa triển khai code)
```text
/SKILL/claude-skills-pack/
├── update.sh
├── update.ps1
├── docs/
│   ├── PLAN-update-github.md
│   ├── update-strategy.md                # tài liệu quyết định cuối
│   ├── update-runbook.md                 # hướng dẫn vận hành/rollback
│   └── release-policy.md                 # chính sách versioning/release
└── .github/workflows/
    └── release.yml                       # quy trình release (nếu áp dụng)
```

## Task Breakdown

### Task T01
- **task_id:** T01
- **name:** Xác nhận yêu cầu nghiệp vụ update
- **agent:** product-owner
- **skills:** requirement-clarification
- **priority:** P0
- **dependencies:** []
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: Câu hỏi người dùng + context hiện tại
  - OUTPUT: Biên bản quyết định nguồn update (A/B/C)
  - VERIFY: Có văn bản chốt 1 nguồn mặc định + 1 fallback
- **Rollback:** Nếu chưa chốt được, quay lại chế độ câu hỏi (Socratic) và tạm đóng băng thay đổi kỹ thuật.

### Task T02
- **task_id:** T02
- **name:** Khảo sát luồng update hiện tại (Linux/Windows)
- **agent:** backend-specialist
- **skills:** script-analysis
- **priority:** P0
- **dependencies:** [T01]
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: `update.sh`, `update.ps1`, README
  - OUTPUT: Tài liệu "as-is update flow"
  - VERIFY: Mô tả được source, trigger, lỗi phổ biến, path rollback hiện tại
- **Rollback:** Nếu script thiếu nhất quán, đánh dấu risk blocker trước khi thiết kế mới.

### Task T03
- **task_id:** T03
- **name:** Phân tích bảo mật kênh update
- **agent:** security-auditor
- **skills:** supply-chain-security
- **priority:** P0
- **dependencies:** [T02]
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: As-is flow + phương án A/B/C
  - OUTPUT: Security requirements (checksum/signature/trust source)
  - VERIFY: Có checklist kiểm chứng integrity và anti-tampering
- **Rollback:** Nếu không đáp ứng baseline bảo mật, loại phương án khỏi shortlist.

### Task T04
- **task_id:** T04
- **name:** Thiết kế chiến lược versioning + rollback
- **agent:** devops-engineer
- **skills:** release-strategy
- **priority:** P1
- **dependencies:** [T03]
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: Quyết định nguồn update + security requirements
  - OUTPUT: Chính sách release, rollback, retention
  - VERIFY: Có kịch bản rollback thành công cho 3 case lỗi chính
- **Rollback:** Nếu rollback quá phức tạp, chuyển về chiến lược release đơn giản hơn (chỉ stable channel).

### Task T05
- **task_id:** T05
- **name:** Soạn runbook vận hành update
- **agent:** documentation-writer
- **skills:** operational-docs
- **priority:** P1
- **dependencies:** [T04]
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: Kết quả T01-T04
  - OUTPUT: `docs/update-runbook.md`
  - VERIFY: Người mới có thể làm theo runbook để update + rollback bằng checklist
- **Rollback:** Nếu runbook khó hiểu, rút gọn về quy trình 1 kênh stable trước.

### Task T06
- **task_id:** T06
- **name:** Định nghĩa tiêu chí test cho cơ chế update
- **agent:** test-engineer
- **skills:** test-planning
- **priority:** P1
- **dependencies:** [T04]
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: release/rollback policy
  - OUTPUT: test matrix (OS x channel x failure mode)
  - VERIFY: Bao phủ ít nhất: success update, network fail, checksum fail, rollback pass
- **Rollback:** Nếu không đủ môi trường test, ưu tiên smoke test 2 OS trước, mở rộng sau.

### Task T07
- **task_id:** T07
- **name:** Chốt quyết định cuối và truyền thông cho người dùng
- **agent:** product-manager
- **skills:** decision-communication
- **priority:** P2
- **dependencies:** [T05, T06]
- **INPUT→OUTPUT→VERIFY:**
  - INPUT: Runbook + test matrix + risk register
  - OUTPUT: Quyết định "update from GitHub" dạng rõ ràng, public trong docs
  - VERIFY: README/docs trả lời trực tiếp câu hỏi người dùng trong 1 đoạn ngắn
- **Rollback:** Nếu phản hồi người dùng không đồng thuận, mở review vòng 2 với phương án fallback.

## Phase X: Verification Checklist (Plan-level)
- [ ] Câu hỏi Socratic đã được trả lời hoặc default đã được chấp nhận.
- [ ] Có quyết định nguồn update mặc định (A/B/C) bằng văn bản.
- [ ] Có tài liệu rollback tối thiểu 3 tình huống lỗi.
- [ ] Có test matrix Linux + Windows.
- [ ] Có owner cho từng task và dependency rõ ràng.
- [ ] Không có code change trong giai đoạn planning.

## Risks and Mitigation
1. **Rủi ro:** Dùng `git pull` trực tiếp gây update ngoài kiểm soát.  
   **Giảm thiểu:** Chuyển mặc định sang release tag cố định.
2. **Rủi ro:** Artifact bị thay thế/tampering.  
   **Giảm thiểu:** checksum/signature + verify trước apply.
3. **Rủi ro:** Rollback không hoạt động trên một OS.  
   **Giảm thiểu:** test matrix tách Linux/Windows + dry-run rollback.
4. **Rủi ro:** Người dùng hiểu sai kênh update.  
   **Giảm thiểu:** README FAQ nêu rõ “Update lấy từ đâu?”

## Dependency Graph (Tóm tắt)
- T01 → T02 → T03 → T04
- T04 → T05
- T04 → T06
- T05 + T06 → T07

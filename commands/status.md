---
description: Display project and development status. Progress tracking and status board.
---

# Show Status

$ARGUMENTS

---

## Task

Show current project and development status.

### What It Shows

1. **Project Info**
   - Project name and path
   - Tech stack
   - Current features

2. **Development Status**
   - Completed tasks
   - In-progress work
   - Pending items

3. **File Statistics**
   - Files created count
   - Files modified count

4. **Preview Status**
   - Is server running
   - URL
   - Health check

---

## Example Output

```
=== Project Status ===

📁 Project: my-ecommerce
📂 Path: C:/projects/my-ecommerce
🏷️ Type: nextjs-ecommerce
📊 Status: active

🔧 Tech Stack:
   Framework: next.js
   Database: postgresql
   Auth: clerk
   Payment: stripe

✅ Features (5):
   • product-listing
   • cart
   • checkout
   • user-auth
   • order-history

⏳ Pending (2):
   • admin-panel
   • email-notifications

📄 Files: 73 created, 12 modified

=== Development Status ===

✅ Database schema → Completed
✅ API endpoints → Completed
🔄 Dashboard UI → In Progress (60%)
⏳ Testing → Waiting

=== Preview ===

🌐 URL: http://localhost:3000
💚 Health: OK
```

---

## Quick Commands

```bash
# Check git status
git status

# Count files
find . -type f -name "*.ts" | wc -l

# Check running servers
lsof -i :3000  # macOS/Linux
netstat -ano | findstr :3000  # Windows

# Check dependencies
npm list --depth=0
```

---

## Status Indicators

| Icon | Meaning |
|------|---------|
| ✅ | Completed |
| 🔄 | In Progress |
| ⏳ | Pending/Waiting |
| ❌ | Failed/Blocked |
| 💚 | Healthy |
| 💛 | Warning |
| 🔴 | Error |

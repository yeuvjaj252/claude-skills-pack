---
description: Preview server start, stop, and status check. Local development server management.
---

# Preview Management

$ARGUMENTS

---

## Task

Manage preview server: start, stop, status check.

### Commands

```
/preview           - Show current status
/preview start     - Start server
/preview stop      - Stop server
/preview restart   - Restart
/preview check     - Health check
```

---

## Usage Examples

### Start Server
```
/preview start

Response:
🚀 Starting preview...
   Port: 3000
   Type: Next.js

✅ Preview ready!
   URL: http://localhost:3000
```

### Status Check
```
/preview

Response:
=== Preview Status ===

🌐 URL: http://localhost:3000
📁 Project: C:/projects/my-app
🏷️ Type: nextjs
💚 Health: OK
```

### Port Conflict
```
/preview start

Response:
⚠️ Port 3000 is in use.

Options:
1. Start on port 3001
2. Close app on 3000
3. Specify different port

Which one? (default: 1)
```

---

## Framework Detection

| Files Present | Framework | Start Command |
|--------------|-----------|---------------|
| `next.config.*` | Next.js | `npm run dev` |
| `vite.config.*` | Vite | `npm run dev` |
| `nuxt.config.*` | Nuxt | `npm run dev` |
| `svelte.config.*` | SvelteKit | `npm run dev` |
| `package.json` (react) | Create React App | `npm start` |
| `index.html` only | Static | `npx serve` |

---

## Common Issues

### Port Already in Use
```bash
# Find process on port
lsof -i :3000  # macOS/Linux
netstat -ano | findstr :3000  # Windows

# Kill process
kill -9 <PID>  # macOS/Linux
taskkill /PID <PID> /F  # Windows
```

### Server Won't Start
1. Check `package.json` for start script
2. Verify dependencies installed (`npm install`)
3. Check for syntax errors in config files
4. Look at terminal output for specific errors

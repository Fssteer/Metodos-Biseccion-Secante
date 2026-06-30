#!/bin/bash
set -e

echo "▶ Iniciando backend FastAPI en :8080..."
cd /app/backend
/app/venv-backend/bin/uvicorn main:app --host 0.0.0.0 --port 8080 &

echo "▶ Iniciando frontend Reflex en :3000..."
cd /app/frontend

# Parchear allowedHosts en segundo plano: espera a que vite.config.js exista/cambie y lo parchea
(
  while true; do
    if [ -f /app/frontend/.web/vite.config.js ] && ! grep -q "allowedHosts" /app/frontend/.web/vite.config.js; then
      sed -i 's/port: process.env.PORT,/port: process.env.PORT,\n    allowedHosts: true,/' /app/frontend/.web/vite.config.js
      echo "✔ vite.config.js parcheado con allowedHosts: true"
    fi
    sleep 2
  done
) &

/app/venv-frontend/bin/reflex run --env dev --backend-host 0.0.0.0 --frontend-port 3000 --backend-port 8001

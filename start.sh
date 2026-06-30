#!/bin/bash
set -e

echo "▶ Iniciando backend FastAPI en :8080..."
cd /app/backend
/app/venv-backend/bin/uvicorn main:app --host 0.0.0.0 --port 8080 &

echo "▶ Iniciando frontend Reflex en :3000..."
cd /app/frontend
/app/venv-frontend/bin/reflex run --env dev --backend-host 0.0.0.0 --frontend-port 3000 --backend-port 8001

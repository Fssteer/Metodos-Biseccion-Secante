FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# ── Entorno virtual para el BACKEND (aislado) ──
RUN python -m venv /app/venv-backend
COPY backend/requirements.txt ./backend/requirements.txt
RUN /app/venv-backend/bin/pip install --no-cache-dir --upgrade pip && \
    /app/venv-backend/bin/pip install --no-cache-dir -r backend/requirements.txt

# ── Entorno virtual para el FRONTEND (aislado) ──
RUN python -m venv /app/venv-frontend
COPY frontend/requirements.txt ./frontend/requirements.txt
RUN /app/venv-frontend/bin/pip install --no-cache-dir --upgrade pip && \
    /app/venv-frontend/bin/pip install --no-cache-dir -r frontend/requirements.txt

# ── Copiar código ──
COPY backend/ ./backend/
COPY frontend/ ./frontend/

# ── Inicializar Reflex usando SU venv ──
WORKDIR /app/frontend
RUN /app/venv-frontend/bin/reflex init --loglevel debug || true

WORKDIR /app
COPY start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 3000 8080

CMD ["./start.sh"]

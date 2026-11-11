# Railway deployment: OpenDataLoader PDF hybrid server (FastAPI + Docling)
FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONUTF8=1 \
    PIP_NO_CACHE_DIR=1 \
    HF_HOME=/data/cache/huggingface \
    XDG_CACHE_HOME=/data/cache

# OpenCV/EasyOCR runtime libs; Tesseract is optional (see README_RAILWAY.md)
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 libglib2.0-0 libgomp1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements-railway.txt .
RUN pip install -r requirements-railway.txt

COPY railway-start.sh .
RUN chmod +x railway-start.sh

# Railway injects $PORT at runtime
CMD ["./railway-start.sh"]

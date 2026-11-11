# Deploying on Railway

This deploys the **hybrid server** (`opendataloader-pdf-hybrid`): a FastAPI service with
`GET /health` and `POST /v1/convert/file` (multipart `files`, optional `page_ranges`).
It returns Docling JSON; the Java CLI/SDK client turns that into Markdown/JSON/HTML.

## Steps
1. Push these files to your repo (Dockerfile, requirements-railway.txt, railway-start.sh, railway.json, .dockerignore).
2. Railway -> New Project -> Deploy from GitHub repo. It will pick up `railway.json`.
3. Add a **Volume** mounted at `/data` (caches Docling/EasyOCR models, which are
   downloaded on first start and take minutes).
4. Memory: give the service at least 4-8 GB RAM (Docling models are heavy).
5. Generate a domain (or use private networking) and check `/health`.

## Variables (all optional)
| Variable | Default | Meaning |
|---|---|---|
| `ODL_EXTRA_ARGS` | empty | e.g. `--force-ocr --ocr-lang ko,en`, `--enrich-formula` |
| `ODL_MAX_FILE_MB` | 50 | upload limit (0 = unlimited) |
| `ODL_DEVICE` | cpu | `cpu` / `cuda` / `auto` |

## Security
The server has **no authentication** and accepts unlimited-by-default uploads.
Prefer Railway private networking (don't generate a public domain) and call it from
your own service, or put an authenticating proxy in front of it.

## Client usage
    opendataloader-pdf file.pdf --hybrid docling-fast --hybrid-url https://<your-domain>

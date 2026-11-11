#!/usr/bin/env bash
set -euo pipefail

# Optional flags via Railway variables:
#   ODL_EXTRA_ARGS   e.g. "--force-ocr --ocr-lang ko,en --enrich-formula"
#   ODL_MAX_FILE_MB  upload limit in MB (0 = unlimited)
exec opendataloader-pdf-hybrid \
  --host 0.0.0.0 \
  --port "${PORT:-5002}" \
  --device "${ODL_DEVICE:-cpu}" \
  --max-file-size "${ODL_MAX_FILE_MB:-50}" \
  ${ODL_EXTRA_ARGS:-}

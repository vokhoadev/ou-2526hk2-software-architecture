#!/usr/bin/env bash
# Xuất PDF từ bản hợp nhất. Chạy từ thư mục gốc sach-HopNhat-ITEC2313:
#   bash build/build-pdf.sh
#   bash build/build-pdf.sh path/to/out.pdf
#
# PDF cần: pandoc, LaTeX (xelatex), rsvg-convert (brew install librsvg) và gói TeX svg.
# Nếu thiếu, script tự xuất file .html cùng tên (đổi đuôi).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
OUT="${1:-Sach-KienTruc-PhanMem-HopNhat.pdf}"
HTML_OUT="${OUT%.pdf}.html"
[[ "$HTML_OUT" == "$OUT" ]] && HTML_OUT="${OUT}.html"
RP="$ROOT:$ROOT/assets/figures:$ROOT/assets/figures/part-01:$ROOT/assets/figures/part-01/sketchnotes:$ROOT/assets/figures/part-02:$ROOT/assets/figures/part-03"
FILES=$(grep -v '^[[:space:]]*$' "$ROOT/build/book-order.txt" | tr '\n' ' ')

run_pandoc() {
  pandoc --from=markdown-yaml_metadata_block --file-scope $FILES \
    --toc --toc-depth=3 \
    --resource-path="$RP" \
    -V lang=vi \
    "$@"
}

if command -v rsvg-convert >/dev/null 2>&1 && command -v xelatex >/dev/null 2>&1; then
  if run_pandoc -o "$OUT" --pdf-engine=xelatex; then
    echo "Wrote $OUT"
    exit 0
  fi
fi

echo >&2 "PDF không tạo được (thiếu rsvg-convert và/hoặc xelatex, hoặc thiếu gói LaTeX 'svg')."
echo >&2 "Gợi ý macOS: brew install librsvg; cài MacTeX hoặc BasicTeX + tlmgr install svg."
echo >&2 "Đang xuất HTML thay thế…"

run_pandoc -s -o "$HTML_OUT"
echo "Wrote $HTML_OUT"

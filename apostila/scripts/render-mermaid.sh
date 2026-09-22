#!/usr/bin/env bash
# Renderiza diagramas Mermaid (.mmd) em figuras para o LaTeX.
#
# Uso (de dentro de apostila/):
#   ./render-mermaid.sh              # diagramas/*.mmd -> figuras/*.pdf
#   ./render-mermaid.sh --png        # gera tambem .png (para o DOCX)
#   ./render-mermaid.sh -i src -o out
#
# Se o mmdc falhar (falta Chromium headless, por exemplo), o diagrama NAO deve
# ficar quebrado no PDF: desenhe-o em TikZ e cite o .mmd como referencia.
#
# Sobre --pdfFit (verificado): sem ele o mmdc gera uma pagina Carta (612x792 pt)
# com o diagrama pequeno no centro; com ele a pagina recorta o diagrama, e o
# \includegraphics[width=\linewidth] passa a ampliar de verdade o desenho.
set -euo pipefail

SRC="diagramas"
OUT="figuras"
WANT_PNG=0
while [ $# -gt 0 ]; do
  case "$1" in
    --png) WANT_PNG=1; shift ;;
    -i) SRC="$2"; shift 2 ;;
    -o) OUT="$2"; shift 2 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "argumento desconhecido: $1" >&2; exit 2 ;;
  esac
done

command -v mmdc >/dev/null || { echo "erro: mmdc (mermaid-cli) nao encontrado" >&2; exit 1; }
[ -d "$SRC" ] || { echo "erro: pasta '$SRC' nao existe" >&2; exit 1; }
mkdir -p "$OUT"

shopt -s nullglob
files=("$SRC"/*.mmd)
if [ ${#files[@]} -eq 0 ]; then
  echo "nenhum .mmd em '$SRC' — nada a fazer"
  exit 0
fi

# O mmdc precisa de um navegador. O ambiente tem google-chrome, mas o Chromium
# embutido do Puppeteer NAO esta instalado: sem isto o mmdc falha com "Could not
# find chrome-headless-shell". Detecta o navegador do sistema automaticamente.
opts=()
cfg_tmp=""
if [ -n "${MERMAID_PUPPETEER_CONFIG:-}" ] && [ -f "$MERMAID_PUPPETEER_CONFIG" ]; then
  opts+=(--puppeteerConfigFile "$MERMAID_PUPPETEER_CONFIG")
else
  for b in google-chrome google-chrome-stable chromium chromium-browser; do
    if command -v "$b" >/dev/null 2>&1; then
      cfg_tmp="$(mktemp -t mmdc-puppeteer-XXXXXX.json)"
      printf '{"executablePath":"%s","args":["--no-sandbox","--disable-dev-shm-usage","--disable-gpu"]}\n' \
        "$(command -v "$b")" >"$cfg_tmp"
      opts+=(--puppeteerConfigFile "$cfg_tmp")
      echo "navegador para o mmdc: $b"
      break
    fi
  done
fi
trap '[ -n "$cfg_tmp" ] && rm -f "$cfg_tmp"' EXIT

ok=0
fail=0
for f in "${files[@]}"; do
  base="$(basename "$f" .mmd)"
  if mmdc -i "$f" -o "$OUT/$base.pdf" --pdfFit -q "${opts[@]}" 2>"$OUT/$base.log"; then
    ok=$((ok + 1))
    echo "ok: $OUT/$base.pdf"
    if [ "$WANT_PNG" -eq 1 ]; then
      mmdc -i "$f" -o "$OUT/$base.png" -b white -s 3 -q "${opts[@]}" 2>>"$OUT/$base.log" \
        && echo "ok: $OUT/$base.png" \
        || echo "aviso: PNG de $base falhou" >&2
    fi
  else
    fail=$((fail + 1))
    rm -f "$OUT/$base.pdf"
    echo "FALHOU: $base — desenhe em TikZ (log: $OUT/$base.log)" >&2
  fi
done

echo "$ok renderizado(s), $fail falha(s)"
[ "$fail" -eq 0 ]

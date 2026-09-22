#!/usr/bin/env bash
# Extrai o texto das fontes da apostila (PDF/DOCX) para apostila/fontes/.
# Insumo de trabalho: NAO e entrega final.
#
# Uso (de dentro de apostila/):
#   ./extrair-fontes.sh                 # ../docs/*.pdf
#   ./extrair-fontes.sh /caminho/dir    # outra pasta de fontes
#   ./extrair-fontes.sh arquivo1.pdf arquivo2.pdf
#
# Estratégia: anydoc (Markdown) e, se falhar, pdftotext -layout.
# exit 3 do anydoc = paginas exigindo OCR: ver /memories/repo/anydoc-conversao.md
# O arquivo fontes/<slug>.err guarda a saida bruta do anydoc quando a conversao
# nao foi limpa — e o primeiro lugar a olhar quando algo vier truncado.
set -euo pipefail

OUT="fontes"
mkdir -p "$OUT"

# --- Coleta os arquivos de entrada ---
inputs=()
if [ $# -eq 0 ]; then
  shopt -s nullglob
  inputs=("$(dirname "$OUT")/../docs"/*.pdf)
  if [ ${#inputs[@]} -eq 0 ]; then
    echo "erro: nenhum PDF em ../docs — passe o caminho ou os arquivos" >&2
    exit 1
  fi
elif [ -d "$1" ]; then
  shopt -s nullglob
  inputs=("$1"/*.pdf)
  [ ${#inputs[@]} -gt 0 ] || { echo "erro: nenhum PDF em '$1'" >&2; exit 1; }
else
  inputs=("$@")
fi

slugify() { # nome de arquivo -> slug ascii simples
  printf '%s' "$1" \
    | iconv -f utf-8 -t ascii//TRANSLIT 2>/dev/null \
    | tr '[:upper:]' '[:lower:]' \
    | tr -c '[:alnum:]' '-' \
    | tr -s '-' | sed 's/^-//; s/-$//'
}

for pdf in "${inputs[@]}"; do
  [ -f "$pdf" ] || { echo "aviso: '$pdf' nao existe — ignorado" >&2; continue; }
  slug="$(slugify "$(basename "$pdf" .pdf)")"
  echo "== $pdf -> $OUT/$slug"

  rc=0
  if command -v npx >/dev/null 2>&1; then
    set +e
    npx -y @firecrawl/anydoc "$pdf" -o "$OUT/$slug.md" 2>"$OUT/$slug.err"
    rc=$?
    set -e
  else
    rc=127
  fi

  case "$rc" in
    0)
      echo "   ok (anydoc): $OUT/$slug.md"
      rm -f "$OUT/$slug.err"
      ;;
    3)
      echo "   aviso: paginas exigem OCR (anydoc exit 3)." >&2
      echo "   receita: /memories/repo/anydoc-conversao.md" >&2
      pdftotext -layout "$pdf" "$OUT/$slug.txt"
      echo "   fallback (pdftotext): $OUT/$slug.txt"
      ;;
    *)
      echo "   aviso: anydoc indisponivel/falhou (rc=$rc); usando pdftotext" >&2
      pdftotext -layout "$pdf" "$OUT/$slug.txt"
      echo "   ok (pdftotext): $OUT/$slug.txt"
      ;;
  esac
done

echo
echo "Proximo passo: ler $OUT/*.md|.txt e montar INVENTARIO.md (etapa 1)."

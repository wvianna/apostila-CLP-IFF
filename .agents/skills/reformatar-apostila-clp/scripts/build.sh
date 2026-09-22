#!/usr/bin/env bash
# Compila a apostila de CLP (template-raiz LaTeX) para PDF e, opcionalmente, DOCX.
# latexmk NAO existe neste ambiente: aqui as passadas sao explicitas.
#
# Uso:
#   ./build.sh                    # compila apostila.tex no diretorio atual
#   ./build.sh raiz.tex           # outra raiz
#   ./build.sh --docx             # PDF + apostila.docx
#
# Rode de dentro da pasta apostila/ (onde estao apostila.tex, capitulos/ e figuras/).
set -euo pipefail

ROOT="apostila.tex"
MAKE_DOCX=0
for arg in "$@"; do
  case "$arg" in
    --docx) MAKE_DOCX=1 ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
    *) ROOT="$arg" ;;
  esac
done

command -v pdflatex >/dev/null || { echo "erro: pdflatex nao encontrado" >&2; exit 1; }
[ -f "$ROOT" ] || { echo "erro: '$ROOT' nao encontrado (rode de dentro de apostila/)" >&2; exit 1; }

BASE="${ROOT%.tex}"
mkdir -p build

# Com -file-line-error o TeX nao escreve "! msg": escreve "arquivo.tex:linha: msg".
# Detectar apenas "^! " fazia o script reportar 0 erros com o log cheio deles.
ERROR_RE='^! |\.tex:[0-9]+: '
count_errors() { grep -cE "$ERROR_RE" "$1" 2>/dev/null || true; }
show_errors()  { grep -nE "$ERROR_RE" "$1" 2>/dev/null | head -15 | cut -c1-140 | sed 's/^/   /'; }
# Pre-flight: figuras citadas mas ausentes. Sem isto o pdflatex reclama no meio
# da compilacao e o PDF sai com area vazia, dificil de localizar.
missing=0
while IFS= read -r img; do
  [ -z "$img" ] && continue
  if [ -f "$img" ] || [ -f "figuras/$(basename "$img")" ]; then
    continue
  fi
  echo "aviso: figura ausente -> $img" >&2
  missing=$((missing + 1))
done < <(grep -rhoE '\\includegraphics(\[[^]]*\])?\{[^}]+\}' . --include='*.tex' 2>/dev/null \
         | sed -E 's/.*\{([^}]*)\}.*/\1/' | sort -u)
if [ "$missing" -gt 0 ]; then
  echo "aviso: $missing figura(s) ausente(s) — o PDF sairá com área vazia no lugar" >&2
fi

pass() {
  local n="$1"
  local errs
  echo "== pdflatex (passada $n) =="
  # Sem -halt-on-error: queremos o PDF mesmo com erro, para inspecionar;
  # os erros são coletados e reportados no final.
  pdflatex -interaction=nonstopmode -file-line-error \
           -output-directory=build "$ROOT" >"build/pass$n.log" 2>&1 || true
  errs=$(count_errors "build/pass$n.log")
  echo "   $errs erro(s) de TeX"
  if [ "${errs:-0}" -gt 0 ]; then
    show_errors "build/pass$n.log"
  fi
}

pass 1

if [ -f "build/$BASE.idx" ]; then
  echo "== makeindex =="
  makeindex -q -o "build/$BASE.ind" "build/$BASE.idx" || echo "aviso: makeindex falhou (indice remissivo vazio)" >&2
fi

pass 2
pass 3

if grep -qE 'Citation .* undefined|Reference .* undefined|There were undefined (references|citations)' "build/pass3.log"; then
  echo "aviso: ha referencias/citacoes nao resolvidas — veja build/pass3.log" >&2
fi
if grep -q 'SKILL-apostila: capitulo ausente' "build/pass3.log"; then
  echo "aviso: capitulos ainda nao escritos:" >&2
  grep -o 'capitulos/[^ ]*\.tex' "build/pass3.log" | sort -u | sed 's/^/  - /' >&2
fi

cp "build/$BASE.pdf" "$BASE.pdf" 2>/dev/null || {
  echo "erro: nenhum PDF gerado — veja build/pass3.log" >&2
  exit 1
}
PAGES="$(pdfinfo "$BASE.pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
echo "ok: $BASE.pdf${PAGES:+ ($PAGES paginas)}"

ERRS=$(count_errors build/pass3.log)
if [ "${ERRS:-0}" -gt 0 ]; then
  echo "FALHOU: ${ERRS} erro(s) de TeX — corrija antes de considerar pronto" >&2
  exit 2
fi

if [ "$MAKE_DOCX" -eq 1 ]; then
  if command -v pandoc >/dev/null; then
    echo "== pandoc (DOCX) =="
    # Verificado: pandoc segue o \input dentro de \chapterfile, entao os capitulos
    # entram no DOCX. Ele avisa sobre os capitulos ainda ausentes — e so aviso.
    # Conferencia rapida: pandoc apostila.docx -t plain | wc -w
    # Limitacao real: TikZ/circuitikz e lstlisting nao sobrevivem a conversao.
    # Para DOCX fiel, gere tambem PNG dos diagramas (render-mermaid.sh --png).
    if pandoc "$ROOT" -o "$BASE.docx" --toc --from latex \
         --resource-path=figuras:capitulos 2>"build/pandoc.log"; then
      WORDS=$(pandoc "$BASE.docx" -t plain 2>/dev/null | wc -w || echo 0)
      echo "ok: $BASE.docx ($WORDS palavras; tikz/tabelas podem faltar)"
    else
      echo "aviso: pandoc falhou — veja build/pandoc.log" >&2
    fi
  else
    echo "aviso: pandoc ausente; DOCX nao gerado" >&2
  fi
fi

# Controladores Lógicos Programáveis

Apostila didática de automação industrial do **Instituto Federal Fluminense** (Campus Campos dos
Goytacazes), para o curso de **Engenharia de Controle e Automação** e o **Curso Técnico em
Automação Industrial**.

Reformulação e atualização em LaTeX de duas apostilas anteriores, com diferenciação explícita entre
**CLP conforme a norma IEC 61131-3** e **CLP legado de fabricante** — o eixo do material.

**Autores:** M.Sc. Leonardo de Oliveira Tavares · D.Sc. William da Silva Vianna · M.Sc. Natália Nogueira Monteiro

**Revisão técnica:** M.Sc. Karina Terra de Souza Campelo

[Licença CC BY-SA 4.0](LICENSE.md) · 5 partes · 25 capítulos · 4 apêndices

## O que tem aqui

| Parte | Capítulos | Assunto |
| --- | --- | --- |
| I | 1–4 | Fundamentos, evolução dos CLPs e projeto de automação |
| II | 5–9 | Hardware: memória, tipos de dados, cartões de E/S, resolução, porte e princípio de funcionamento |
| III | 10–16 | Programação e normas: linguagens, modelo IEC 61131-3, **IEC versus legado**, boas práticas, documentação e teste |
| IV | 17–23 | Integração: SCADA, IIoT e OPC UA, dados em tempo real, interoperabilidade, convergência TI/TO, segurança cibernética e eficiência energética |
| V | 24–25 | Manutenção e formação contínua |

Apêndices: práticas de laboratório · **guia de conversão legado → IEC 61131-3** · glossário ·
referências.

> [!NOTE]
> Obra completa: 25 capítulos e 4 apêndices, PDF de 190 páginas. O estado detalhado, as métricas de
> verificação e as pendências de revisão estão em [`status.md`](status.md); o roteiro para retomar o
> trabalho está em [`handoff.md`](handoff.md).

## Estrutura do repositório

```text
.
├── apostila/              # a obra em LaTeX
│   ├── apostila.tex       # raiz: capa, partes e inclusão dos capítulos
│   ├── capitulos/*.tex    # 25 capítulos + 4 apêndices, um arquivo cada
│   ├── diagramas/*.mmd    # fontes Mermaid versionadas
│   ├── figuras/*.pdf      # figuras renderizadas (artefatos)
│   ├── scripts/           # build, extração de fontes e render de diagramas
│   ├── build/             # artefatos de compilação (aux, log, toc, ind)
│   ├── INVENTARIO.md      # auditoria das apostilas de origem
│   ├── PLANO.md           # plano editorial e lotes de execução
│   └── apostila.pdf       # produto final (190 páginas)
├── docs/                  # fontes de origem (PDFs) e enunciado dos requisitos
├── .agents/skills/        # a skill que executa o processo
├── LICENSE.md             # licença e ressalvas sobre material de terceiros
├── handoff.md             # roteiro para retomar o trabalho
└── status.md              # estado atual e métricas de verificação
```

## Compilar o PDF

### Pré-requisitos

| Ferramenta | Para quê | Neste ambiente |
| --- | --- | --- |
| `pdflatex` (TeX Live) | compilar o PDF | `/usr/bin/pdflatex` |
| `makeindex` | gerar o índice remissivo | `/usr/bin/makeindex` |
| `mmdc` (mermaid-cli) + navegador | regenerar os diagramas | `mmdc` + `google-chrome` |
| `pdftoppm`, `pdfinfo` (poppler-utils) | conferir o resultado | disponíveis |

Duas ausências importantes deste ambiente:

- **`latexmk` não está instalado** — por isso existe o `scripts/build.sh`, que faz as passadas
  explicitamente. Não use `latexmk`.
- **`siunitx` não está instalado** — o texto escreve as unidades literalmente (`24\,V`,
  `4--20\,mA`); não use `\SI` nem `\qty`.

### Compilar

```bash
cd apostila
./scripts/build.sh
```

O script roda `pdflatex` três vezes com `makeindex` entre a primeira e a segunda passada, lista as
figuras ausentes antes de compilar, mostra os erros de cada passada e **sai com código 2 se houver
erro de TeX**. O resultado é gravado em `apostila/apostila.pdf`; os artefatos (`aux`, `log`, `toc`,
`lof`, `lot`, `ind`) ficam em `apostila/build/`.

Saída esperada, com a obra no estado atual:

```text
== pdflatex (passada 1) ==
   0 erro(s) de TeX
== makeindex ==
== pdflatex (passada 2) ==
   0 erro(s) de TeX
== pdflatex (passada 3) ==
   0 erro(s) de TeX
ok: apostila.pdf (190 paginas)
```

O script aceita outra raiz como argumento (`./scripts/build.sh outra-raiz.tex`). A opção `--docx`
também existe, mas **não é usada**: a exportação DOCX está fora do escopo desta obra.

### Regenerar os diagramas

Só é necessário ao editar algum arquivo de `diagramas/*.mmd`:

```bash
./scripts/render-mermaid.sh          # diagramas/*.mmd -> figuras/*.pdf
```

O script autodetecta o navegador para o `mmdc` e recorta a página ao desenho. Sem essa etapa, um
diagrama novo simplesmente não aparece no PDF.

### Conferir o resultado

Depois de compilar, estas checagens devem passar:

```bash
grep -cE '^! |\.tex:[0-9]+: ' build/pass3.log   # erros de TeX: deve ser 0
grep -c undefined build/pass3.log                # referências pendentes: deve ser 0
grep -c 'Overfull .vbox' build/pass3.log         # figuras maiores que a página: deve ser 0
pdfinfo apostila.pdf | grep ^Pages               # páginas (190)
```

Um transbordo horizontal (tabela ou listagem mais larga que a mancha) é **silencioso**, então vale
medir o tamanho: nenhum deve passar de 5 pt.

```bash
grep -oE 'Overfull \\hbox \(([0-9.]+)pt' build/pass3.log | \
  awk -F'[(]' '{split($2,a,"pt"); if (a[1]+0 > 5) n++} END {print n+0}'   # deve ser 0
```

E uma conferência **visual**, que o compilador não faz por você — ele acusa erro de sintaxe, mas não
acusa figura ilegível nem tabela que passou da margem:

```bash
pdftoppm -f 168 -l 168 -r 100 -png apostila.pdf /tmp/pagina   # abra a imagem gerada
```

### Extrair o texto das fontes

```bash
./scripts/extrair-fontes.sh <arquivo.pdf>   # PDF -> fontes/*.md
```

O `anydoc` é usado com fallback para `pdftotext`. O resultado é insumo de trabalho em `apostila/fontes/`,
**não** é entrega: as tabelas que ele produz saem colapsadas e não devem ser copiadas.

### Problemas comuns

| Sintoma | Causa provável e solução |
| --- | --- |
| `latexmk: comando não encontrado` | não existe neste ambiente; use `./scripts/build.sh` |
| `LaTeX Error: File 'figuras/xx.pdf' not found` | diagrama não renderizado; rode `./scripts/render-mermaid.sh` |
| `LaTeX Error: File 'siunitx.sty' not found` | pacote ausente; escreva as unidades literalmente |
| Índice remissivo vazio | `makeindex` não rodou; confira o tamanho de `build/apostila.ind` |
| Figura com texto ilegível no PDF | proporção do diagrama muito larga; ver a regra na skill |
| Tabela passando da margem | largura das colunas `p{}` acima do limite — cada coluna custa `2\tabcolsep` |
| Legenda numerada faltando na lista de figuras | erro de TeX engolido; procure no log tanto `^!` quanto o formato `arquivo.tex:linha:` |

## Como este material é produzido

O processo é executado pela skill **`reformatar-apostila-clp`**
(`.agents/skills/reformatar-apostila-clp/`), que define as seis etapas — inventário e auditoria das
fontes, plano editorial, redação, diagramas, compilação e revisão — além das convenções de escrita e
do critério de aceite.

Duas regras valem para todo o texto:

1. **Norma e fabricante nunca se confundem.** Toda linguagem, instrução ou endereçamento é
   apresentado como normatizado ou como dialeto proprietário, com mapa de conversão entre os dois.
2. **Afirmação normativa cita edição e ano.** Edição vigente da IEC 61131-3: **4ª, maio de 2025**
   (a Lista de Instruções foi depreciada na 3ª edição, de 2013, e removida na 4ª). Nada da norma é
   reproduzido: as referências servem para conferência factual.

## Fontes

| Documento | Papel |
| --- | --- |
| *Controladores Lógicos Programáveis — Apostila Final (Teórica e Prática), Rev. 05D* | fonte principal (105 p.) |
| *CLP 2023* (D.Sc. William da Silva Vianna) | hardware e E/S, SCADA, critérios de aquisição (72 p.) |
| *IEC 61131-3* | referência de conferência — não reproduzida |

## Licença

Distribuído sob **Creative Commons Atribuição–CompartilhaIgual 4.0 Internacional (CC BY-SA 4.0)**:
use, adapte e redistribua, inclusive comercialmente, com atribuição aos autores e a mesma licença nas
obras derivadas. Detalhes e ressalvas sobre material de terceiros em [`LICENSE.md`](LICENSE.md).

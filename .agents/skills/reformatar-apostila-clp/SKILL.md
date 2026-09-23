---
name: reformatar-apostila-clp
description: 'Reformata, atualiza, ilustra e compila a apostila de Controladores Lógicos Programáveis (CLP) em LaTeX, gerando PDF e DOCX. Use when: reformatar apostila de CLP, atualizar apostila, converter apostila Word/PDF para LaTeX, criar ou editar capítulo da apostila, gerar PDF/DOCX da apostila, separar CLPs legados de CLPs conforme IEC 61131-3, criar diagramas mermaid ou circuito para a apostila, revisar conteúdo sobre CLP, SCADA, IoT, OPC UA ou segurança cibernética industrial.'
argument-hint: '[etapa: inventario | plano | redacao | diagramas | build | revisao]'
---

# Reformatação e atualização da apostila de CLP

Converte as fontes em PDF da apostila de CLP em uma obra LaTeX única, atualizada, ilustrada, compilada
em PDF (índice navegável).

**Obra de destino**: *Controladores Lógicos Programáveis* — Instituto Federal Fluminense (IFF),
Campus Campos dos Goytacazes. Autores: **M.Sc. Leonardo de Oliveira Tavares**,
**D.Sc. William da Silva Vianna**, **M.Sc. Natália Nogueira Monteiro**. Curso Técnico em Automação.

## Quando usar

- Atualizar, reorganizar ou reescrever a apostila de CLP.
- Acrescentar capítulo/tópico novo à apostila.
- Migrar o material de Word/PDF para LaTeX e recompilar.
- Gerar diagramas (mermaid, circuito, tabelas) para o material.
- Auditar o legado: o que está desatualizado, o que é específico de fabricante, o que falta.

## Decisões já tomadas pelos autores (não reabrir)

| Tema | Decisão |
| --- | --- |
| Local da skill | `.agents/skills/reformatar-apostila-clp/` (escopo do projeto) |
| Estrutura da obra | Reorganização completa em 5 partes / 25 capítulos, conforme `references/estrutura.md` |
| Capítulo 8 legado (Allen-Bradley) | Reescrever em IEC 61131-3; o legado vira o Apêndice B com o mapa de conversão |
| Exportação DOCX | Pandoc é suficiente; **o PDF é o produto principal** e o critério de aceite |

## Pré-requisitos (já verificados neste ambiente)

| Ferramenta | Status |
| --- | --- |
| `pdflatex`, `xelatex`, `lualatex`, `bibtex`, `makeindex` | disponíveis |
| `latexmk` | **ausente** → use [scripts/build.sh](./scripts/build.sh) |
| `pandoc` | disponível (exportação DOCX) |
| `mmdc` (mermaid-cli), `inkscape`, `dot` | disponíveis |
| `pdftotext`, `tesseract`, `ocrmypdf` | disponíveis |
| `npx -y @firecrawl/anydoc` | conversão DOCX/PPTX/XLSX/PDF → Markdown |

Pacotes LaTeX confirmados: `hyperref`, `booktabs`, `longtable`, `tikz`, `circuitikz`, `listings`,
`tcolorbox`, `geometry`, `fancyhdr`, `imakeidx`, `tocloft`, `titlesec`, `enumitem`, `microtype`,
`adjustbox`, `pdfpages`, `csquotes`, `fontspec`, `babel`, `svg`.

O template em [assets/apostila.tex](./assets/apostila.tex) já foi compilado com sucesso neste
ambiente (capítulos ausentes apenas avisam, não quebram o build).

## Estrutura de diretórios produzida

```
apostila/
├── apostila.tex          # raiz LaTeX (base: assets/apostila.tex)
├── capitulos/*.tex       # 1 arquivo por capítulo
├── figuras/              # .pdf/.png gerados (mermaid, circuitikz, tikz)
├── diagramas/*.mmd       # fontes mermaid
├── codigo/               # listagens (ladder/ST/IL) referenciadas por \lstinputlisting
├── fontes/               # markdown extraído dos PDFs originais (insumo, não entrega)
├── build/                # artefatos de compilação
├── INVENTARIO.md         # etapa 1
├── PLANO.md              # etapa 2
└── apostila.pdf          # produto final
```

## Procedimento

### Etapa 0 — Escopo e versionamento

1. Confirme a revisão anterior: a fonte corrente é
   `docs/Controladores Lógicos Programáveis - APOSTILA FINAL (TEORICA e PRATICA) - Rev 05D.pdf`
   (105 p., Word 2016, 2017, rev. de 2021). Fontes complementares: `docs/CLP_2023.pdf` (72 p.,
   especificação/compra de CLP, SCADA) e `docs/61131-3.pdf` (a própria norma, 2ª ed., 2003).
2. Registre no cabeçalho da obra: edição, revisão, data e autores.
3. Não apague o material legado: ele é a base do texto.

### Etapa 1 — Inventário e auditoria do legado

1. Extraia o texto das fontes: [scripts/extrair-fontes.sh](./scripts/extrair-fontes.sh).
   Se o `anydoc` sair com código 3 (páginas que exigem OCR), siga a receita de OCR em
   `/memories/repo/anydoc-conversao.md`.
2. Monte `apostila/INVENTARIO.md` com, por capítulo do legado: título, páginas, tópicos, figuras/
   tabelas, e o veredito **manter / atualizar / reescrever / fundir / remover**.
3. Rode o checklist de auditoria em [references/convencoes.md](./references/convencoes.md#checklist-de-auditoria-do-legado).
   Achados que o legado atual já produz (repita e amplie a verificação):
   - TOC com numeração quebrada e linhas de `.....` truncadas (artefato do Word).
   - Capítulo 8 inteiramente em mnemônicos **Allen-Bradley/RSLogix** (`XIC`, `XIO`, `OTL`, `JSR`,
     `BSL`, `BSR`, `MOV`, `CPT`, `SQR`, `NEG`) — é **legado vendor-specific**, não é IEC 61131-3.
   - Norma citada é a 2ª edição (2003); a edição vigente é a **4ª (maio de 2025)** — a 3ª (2013)
     introduziu POUs orientadas a objeto e depreciou a Lista de Instruções, removida na 4ª. O XML de
     intercâmbio é a **parte 10** da família (esquemas da PLCopen), não a edição da parte 3.
   - Ausência total de: segurança cibernética, IoT/IIoT e OPC UA, convergência TI/TO, eficiência
     energética, interoperabilidade entre marcas, simulação/hardware-in-the-loop e documentação de
     programa como entrega de engenharia.

### Etapa 2 — Plano editorial (gate)

1. Proponha a estrutura-alvo de [references/estrutura.md](./references/estrutura.md) e o mapeamento
   requisito → capítulo.
2. Escreva `apostila/PLANO.md`: capítulos, seções, tópicos novos, o que migra de onde, e o que sai.
3. **Confirme o plano com o usuário antes de redigir.** Não pule este gate.

### Etapa 3 — Redação em LaTeX

1. Copie [assets/apostila.tex](./assets/apostila.tex) para `apostila/apostila.tex` e ajuste
   edição/revisão/data.
2. Um arquivo por capítulo em `apostila/capitulos/`, incluído via `\include`.
3. Siga [references/convencoes.md](./references/convencoes.md) para rótulos, figuras, tabelas,
   listagens e citações.
4. Conteúdo dos capítulos novos: [references/topicos.md](./references/topicos.md) — cada tópico tem
   os pontos obrigatórios, as normas aplicáveis e as armadilhas.
5. Preserve o rigor técnico: fórmulas (resolução de E/S, cálculo de memória, IEEE-754) migram
   intactas; só a forma muda.

### Etapa 4 — Diagramas, código e figuras

1. Diagramas de fluxo, arquitetura, sequência e TI/TO: escreva `apostila/diagramas/*.mmd` e renderize
   com [scripts/render-mermaid.sh](./scripts/render-mermaid.sh) → `apostila/figuras/*.pdf`.
   O script usa `--pdfFit`: sem ele o mmdc gera uma página Carta com o diagrama pequeno no centro e o
   `\includegraphics[width=\linewidth]` amplia a página vazia em vez do desenho.
2. Circuitos elétricos, partida de motor, botoeira/selos: **TikZ + `circuitikz`** dentro do próprio
   `.tex` (fica versionável e nítido no PDF).
3. Programas ladder/ST/IL: `lstlisting` com o estilo `clp` já definido no template; listagens longas
   vão em `apostila/codigo/` e entram por `\lstinputlisting`.
4. Toda figura/tabela precisa de `\caption` e `\label` e **ser citada no texto** (`\ref{}`), conforme
   o requisito de referência correta.
5. Ao mover ou atualizar uma figura herdada, confira o original em PDF: figuras vetorizadas extraídas
   para Markdown viram grade de tabela e perdem posicionamento.

### Etapa 5 — Compilação e exportação

1. `./scripts/build.sh` a partir de `apostila/` (ou `build.sh raiz.tex`): roda `pdflatex` →
   `makeindex` → `pdflatex` ×2, deixa o PDF em `apostila/` e os artefatos em `build/`.
   Ele **não** para no primeiro erro: lista as figuras ausentes antes de compilar, coleta os erros
   (`^! `) de cada passada e sai com código 2 se houver erro de TeX.
   Verificado neste ambiente: template + 1 capítulo → 13 páginas, 0 erros de TeX.
2. Índice interativo = `hyperref` com `bookmarks` e TOC clicável (já no template). Confira o sumário
   com `pdftotext -f 1 -l 3 apostila.pdf -` e abra o PDF para testar os links e o painel de favoritos.
3. DOCX: `./scripts/build.sh --docx`. Verificado: o pandoc segue o `\input` dentro de `\chapterfile`,
   então os capítulos entram no arquivo — o script imprime a contagem de palavras, use-a como
   sanidade (perto de zero = conteúdo perdido). Limitação real: TikZ/`circuitikz` não convertem e
   tabelas complexas degradam; para o DOCX gere também PNG dos diagramas (`render-mermaid.sh --png`).

### Etapa 6 — Revisão

Rode o [Definition of Done](./references/convencoes.md#definition-of-done) e reporte: páginas, capítulos,
figuras, pendências e o que ficou fora de escopo.

## Regras rígidas

1. **IEC 61131-3 vs. legado é requisito explícito.** Todo tópico de linguagem/programação deve dizer
   se aquilo é normatizado ou proprietário. Não misture `XIC` com contatos `LD`/`AND`/`OR` sem marcar.
2. **Nunca invente número de seção da norma.** Cite edição e ano. Estado verificado da IEC 61131-3:
   1ª ed. 1993, 2ª ed. 2003, 3ª ed. 2013 (introduz POUs orientadas a objeto e **deprecia a Lista de
   Instruções**), **4ª ed. maio de 2025 (vigente; removeu a Lista de Instruções)**. A família vai até
   a parte 10 (a parte 6 é segurança funcional; a 9, SDCI/IO-Link; a 10, intercâmbio XML baseado nos
   esquemas da PLCopen).
3. **Não prometa compatibilidade.** Diga "referenciado em", "implementa o subconjunto", "declarado
   conforme" — e sempre com a versão da norma.
4. **Consolide duplicatas do enunciado.** Os requisitos 13 e 23 pedem o mesmo tópico (documentação de
   programas) e 12 e 20 se sobrepõem (IoT/SCADA vs. análise de dados): um capítulo cada, cobrindo ambos.
5. **Autores e instituição fixos** em capa, folha de rosto e metadados do PDF.
6. **Nada de capítulo órfão:** capítulo sem figura/tabela-exemplo e sem exercícios não passa na etapa 6.
7. Prefira `pdflatex` + `T1`/`utf8`/`babel brazil`; só use `xelatex`/`fontspec` se houver exigência
   tipográfica explícita.

## Armadilhas conhecidas

- `latexmk` não existe aqui: chamar `latexmk` falha silenciosamente em pipelines de CI.
- **`-file-line-error` muda o formato do erro**: o TeX escreve `arquivo.tex:linha: mensagem`, e não
  `! mensagem`. Procurar apenas `^! ` no log dá **zero erros falso** — foi assim que 23 erros de
  `circuitikz` passaram por "compilação limpa" e uma figura desapareceu do PDF. O `build.sh` já
  cobre os dois padrões; se rodar `pdflatex` à mão, use `grep -E '^! |\.tex:[0-9]+: '`.
- **Sintoma de erro engolido**: figura ausente do PDF e sequência de legendas com número faltando
  (ex.: 7.3 seguido de 7.5: o contador subiu, o desenho não saiu). Desconfie da contagem de erros
  antes de culpar o conteúdo.
- **`circuitikz`, armadilhas verificadas**:
  - valor de rótulo com `=` interno precisa de chaves: `l={$R_{sh}=250\,\Omega$}`, nunca
    `l=$R_{sh}=250\,\Omega$`;
  - comando de fonte dentro do rótulo quebra o parser: `l=\scriptsize $1$--$5\,$V` é inválido —
    use `font=\scriptsize` nas opções do ambiente;
  - `\\` dentro de um nó exige `align=center` (ou `align=left`), senão vem "perhaps a missing \item";
  - `npn` não aceita a chave `l=`; a chave `relais` não existe (use `L` para a bobina e
    `closing switch` para o contato);
  - rótulos longos se sobrepõem: posicione com `\node[left|right|below] at (x,y)` em coordenadas livres
    em vez de confiar no posicionamento automático da chave `l=`.
- **Confira sempre o visual**: `pdftoppm -f P -l P -r 130 -png` e olhar a página. Erro de sintaxe o
  compilador acusa; rótulo sobreposto e figura apertada, não.
- `makeindex` antes da 2ª passada, senão o índice remissivo sai vazio.
- **Verificado**: o Chromium embutido do Puppeteer **não** está instalado aqui, então o `mmdc` falha
  com `Could not find chrome-headless-shell`. O `render-mermaid.sh` resolve isso sozinho apontando o
  `executablePath` para o `google-chrome` do sistema via `--puppeteerConfigFile`. Sem navegador algum,
  ele avisa e você desenha em TikZ — figura quebrada nunca vai para o PDF.
- Figura referenciada e ausente não é erro fatal: o `build.sh` avisa antes de compilar e o PDF sai com
  a área vazia (localize pelo aviso, não pelo PDF).
- `\index{}` esquecido deixa o índice remissivo vazio: confira o tamanho de `build/*.ind`, que fica
  com 0 byte quando nenhum capítulo tem entradas de índice.
- **Verificado**: sem `--pdfFit` o `mmdc` produz uma página Carta com o diagrama minúsculo no centro
  (o `width=\linewidth` amplia a folha em branco, não o desenho). O script já passa a opção;
  diagramas muito largos (linhas do tempo) ainda podem pedir `-w`/`-H` maiores.
- **Proporção do diagrama decide a legibilidade** (verificado em 2026-09-22). O `mmdc` recorta a
  página para o diagrama, mas **limita a largura a 600 pt**: diagrama mais largo que isso é reduzido
  para caber, e a fonte encolhe junto. Como a figura é incluída com `width=\linewidth`, o tamanho
  final da fonte é proporcional a `\linewidth` dividido pela largura natural. Regra prática:
  - proporção largura/altura **até 3,5:1** fica legível em `width=\linewidth`;
  - **acima de 6:1** o texto sai em ~3 pt: ilegível. Foi o caso de três diagramas do Lote 4;
  - diagramas verticais (proporção < 1) ficam **grandes demais**: a figura passa da altura da
    página e o LaTeX acusa `Overfull \vbox (... too high)`. Ajuste `width` para ≈
    `460 pt / (altura natural / largura natural) / \linewidth`.
  - **Como medir**: `pdfinfo figuras/x.pdf | grep 'Page size'` dá a proporção; converta-a em altura
    esperada antes de compilar.
  - **Como corrigir um diagrama largo**: quebre em linhas. Em `flowchart LR` com subgrafos, o
    `direction TB` **dentro** do subgrafo é respeitado e empilha os nós — desde que os nós tenham
    arestas entre si; nós soltos ficam lado a lado. Ligue-os com o vínculo invisível `~~~`
    (`A ~~~ B ~~~ C`) e ligue os subgrafos entre si com `~~~`. Alternativa mais simples e robusta:
    cadeia vertical (`flowchart TB`, `A --> B --> C`) com `width` reduzido na inclusão.
- **`Overfull \vbox (... too high)` é silencioso**: não aparece na contagem de erros de TeX, mas
  significa figura mais alta que a página saindo cortada ou empurrando texto. Confira com
  `grep -c 'Overfull .vbox' build/pass3.log` — o esperado é 0.
- **Caixa `tcolorbox` empurrada para o topo da página logo depois de tabela `[H]` sobe para fora da
  folha** (verificado em 2026-09-22, cap. 21). Sintoma: o título da caixa sai cortado na borda
  superior do papel e o cabeçalho desaparece sob o fundo colorido — e o log **não** acusa nada (nem
  `Overfull`, nem `Underfull`). Diagnóstico objetivo:
  `pdftotext -bbox apostila.pdf - | awk -F'"' '/<word / && $4+0 < 40' | wc -l` (o cabeçalho fica em
  ~54,8 pt; valor diferente de zero = conteúdo desenhado acima da mancha). Causa: quando a caixa não
  cabe no resto da página, quem a remaneja é a lógica de quebra do `tcolorbox`, não o TeX, e a
  compensação de `\topskip` sai negativa (deslocamento para cima de `altura da caixa − \topskip`).
  `\clearpage` antes da caixa resolve, mas **não deixe a caixa colada na tabela `[H]`**: uma frase de
  fecho entre as duas já corrige, sem forçar quebra nem deixar buraco na página. Não tente consertar
  mexendo na altura da tabela: quem manda é a célula mais alta de cada linha, então encurtar uma
  célula que não é a mais alta não muda nada.
- **Largura de tabela: `\tabcolsep` entra na conta** (verificado em 2026-09-22). Cada coluna
  `p{x cm}` ocupa `x + 2\tabcolsep`. Com o padrão de 6 pt, uma tabela `p{3.0} p{5.6} p{6.0}` mede
  14,6 cm + 12 pt e **transborda** a mancha de 15,5 cm — o LaTeX registra `Overfull \hbox (... too
  wide) in alignment`, que também **não** aparece na contagem de erros. No projeto verificaram-se
  **31 transbordos** entre 10 pt e 34 pt, em quase todos os capítulos. Correção adotada:
  `\setlength{\tabcolsep}{3pt}` no preâmbulo (resolveu 30 dos 31) mais ajuste pontual da tabela
  restante. Regra para tabelas novas: a soma das larguras `p{}` não deve passar de
  **15,5 cm menos 6 pt por coluna** — na prática, até ~14,6 cm em três colunas e ~14,3 cm em quatro.
  Verificação: `grep -c 'Overfull \\hbox' build/pass3.log` e, para ver o tamanho,
  `grep -oE 'Overfull \\hbox \(([0-9.]+)pt' build/pass3.log`. O esperado é nenhum acima de 5 pt.
- **Listagens (`lstlisting`) também têm limite de coluna**: com o estilo `clp` (`\footnotesize`
  `\ttfamily`), cabem ~70 caracteres por linha. Linhas maiores quebram no meio do desenho ou do
  comentário. Meça com `awk '/begin\{lstlisting\}/{i=1;next} /end\{lstlisting\}/{i=0} i&&length($0)>70'`.
  Cuidado especial com **desenho de Ladder em ASCII**: quebra de linha destrói o alinhamento.
- Chamadas `\include` sempre geram `build/capitulos/*.aux`: não se assuste, é normal.
- Acentuação em `lstlisting` com `pdflatex` quebra se o estilo não tratar bytes; o estilo `clp` do
  template já cobre isso.
- O PDF da norma (`docs/61131-3.pdf`) é RC4-encrypted: leitura/impressão liberadas, cópia de texto
  pode falhar em trechos — confira qualquer citação técnica no documento original.

## Referências do bundle

| Arquivo | Conteúdo |
| --- | --- |
| [references/estrutura.md](./references/estrutura.md) | Estrutura-alvo da obra + mapeamento requisito → capítulo |
| [references/topicos.md](./references/topicos.md) | Pontos obrigatórios, normas e armadilhas de cada tópico novo |
| [references/convencoes.md](./references/convencoes.md) | Convenções LaTeX/editoriais, checklist de auditoria e DoD |
| [assets/apostila.tex](./assets/apostila.tex) | Template-raiz LaTeX (capa, IFF, autores, hyperref, estilos) |
| [scripts/build.sh](./scripts/build.sh) | Compilação PDF (pdflatex + makeindex) e export DOCX |
| [scripts/extrair-fontes.sh](./scripts/extrair-fontes.sh) | Extração das fontes PDF → Markdown |
| [scripts/render-mermaid.sh](./scripts/render-mermaid.sh) | Renderização dos `.mmd` → PDF/PNG para `\includegraphics` |

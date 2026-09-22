# Handoff — nova apostila de CLP

**Para quem chega agora:** leia este arquivo na ordem, depois `status.md` (estado atual) e
`apostila/PLANO.md` (plano editorial e histórico dos lotes). O trabalho é executado pela skill
`.agents/skills/reformatar-apostila-clp/SKILL.md` — **leia a skill antes de editar qualquer coisa**;
ela contém o procedimento, as regras e as armadilhas verificadas.

**Estado: implementação concluída.** Os 6 lotes estão fechados: 25 capítulos + 4 apêndices, 190
páginas, `apostila.pdf` compilando sem erro. O que resta é **revisão do autor** (Seção 6).

---

## 1. Comece por aqui

```bash
cd /home/william/Documentos/CLP/novaApostila

# 1. Entender o que foi decidido e por quê
cat status.md
cat apostila/PLANO.md
cat .agents/skills/reformatar-apostila-clp/SKILL.md
cat .agents/skills/reformatar-apostila-clp/references/convencoes.md   # DoD no fim do arquivo
cat apostila/INVENTARIO.md                                           # auditoria das fontes

# 2. Confirmar que o ponto de partida está saudável
cd apostila && ./scripts/build.sh      # esperado: exit 0, 0 erro, 190 páginas
```

Se o build não passar de **190 páginas com 0 erro, 0 referência indefinida, 0 `Overfull \vbox` e
nenhum `Overfull \hbox` acima de 5 pt**, **pare e investigue** antes de editar conteúdo.

> **Decisão do autor (2026-09-22):** **não** gere nem edite `apostila.docx`. O produto é o PDF. Use
> `./scripts/build.sh` **sem** `--docx`.

---

## 2. Comandos verificados

Sempre a partir de `apostila/`.

| Comando | O que faz |
| --- | --- |
| `./scripts/build.sh` | `pdflatex` ×3 + `makeindex`; gera `apostila.pdf` (raiz) e artefatos em `build/` |
| `./scripts/render-mermaid.sh` | `diagramas/*.mmd` → `figuras/*.pdf` (recorta o diagrama) |
| `./scripts/extrair-fontes.sh <arquivo.pdf>` | PDF → `fontes/*.md` (anydoc, com fallback `pdftotext`) |

O `build.sh` já faz o que você precisa depois de cada edição: lista figuras ausentes, mostra os erros
das três passadas e **sai com código 2 se houver erro de TeX**.

### Verificação obrigatória depois de qualquer edição

```bash
./scripts/build.sh
grep -cE '^! |\.tex:[0-9]+: ' build/pass3.log   # DEVE ser 0 (erro de TeX)
grep -c undefined build/pass3.log                # DEVE ser 0 (referência pendente)
grep -c 'Overfull .vbox' build/pass3.log         # DEVE ser 0 (figura mais alta que a página)
grep -oE 'Overfull \\hbox \(([0-9.]+)pt' build/pass3.log | \
  awk -F'[(]' '{split($2,a,"pt"); if (a[1]+0>5) n++} END{print n+0}'   # DEVE ser 0
pdfinfo apostila.pdf | grep ^Pages
ls -la build/apostila.ind                        # não pode ser 0 byte
# conferência visual — o compilador não vê figura ilegível nem rótulo sobreposto:
pdftoppm -f <página> -l <página> -r 100 -png apostila.pdf /tmp/x   # e ABRA a imagem
```

Dica: `montage /tmp/x-*.png -tile 4x1 -geometry +6+6 /tmp/folha.png` monta uma folha de contato e
economiza chamadas de leitura de imagem. **A página física do PDF é o rótulo impresso + 1.**

---

## 3. Ferramentas: o que existe e o que não existe

| Ferramenta | Situação |
| --- | --- |
| `pdflatex`, `xelatex`, `lualatex`, `bibtex`, `makeindex` | disponíveis |
| **`latexmk`** | **AUSENTE** — não use; o `build.sh` faz as passadas |
| **`siunitx`** | **AUSENTE** — não use `\SI`/`\qty`; escreva `24\,V`, `4--20\,mA` |
| `pandoc` | disponível (não usar: DOCX fora de escopo) |
| `mmdc`, `inkscape`, `dot`, `google-chrome`, `montage` | disponíveis |
| `pdftotext`, `tesseract`, `ocrmypdf`, `qpdf`, `pdfimages` | disponíveis |

### Armadilhas verificadas (todas já custaram retrabalho)

1. **Detecção de erro:** com `-file-line-error`, o TeX escreve `arquivo.tex:linha: msg`, **não**
   `! msg`. Procurar só o padrão de exclamação deu **0 erros com 23 erros reais** no log, e uma figura
   desapareceu do PDF sem ninguém notar. Use `grep -E '^! |\.tex:[0-9]+:'`.
   **Sintoma de erro engolido:** legenda numerada faltando (7.3 seguido de 7.5).
2. **`Overfull \vbox (... too high)` não entra na contagem de erros** e significa figura mais alta que
   a página. Foi assim que três figuras (6.1, 13.1, 16.1) passaram despercebidas, com até 844 pt de
   transbordo.
3. **`Overfull \hbox` em tabela também é silencioso, e o culpado é o `\tabcolsep`.** Cada coluna
   `p{x cm}` ocupa `x + 2\tabcolsep`. Com o padrão de 6 pt, uma tabela de 14,6 cm em três colunas mede
   15,87 cm e transborda a mancha de 15,5 cm. Eram **31 tabelas** assim em quase todos os capítulos.
   O preâmbulo já traz `\setlength{\tabcolsep}{3pt}`; para tabelas novas, mantenha a soma das larguras
   `p{}` em **até ~14,6 cm (três colunas)** ou **~14,3 cm (quatro colunas)**.
4. **Proporção do diagrama decide a legibilidade.** O `mmdc` recorta a página ao diagrama, mas
   **limita a largura a 600 pt**: diagrama mais largo é reduzido e a fonte encolhe junto. Regra:
   - proporção largura/altura até ~**3,5:1** fica legível em `width=\linewidth`;
   - acima de **6:1** sai em ~3 pt — ilegível;
   - diagrama muito vertical estoura a altura: use `width ≈ 460 pt / (altura/largura) / 426 pt`.
   **Meça com** `pdfinfo figuras/x.pdf | grep 'Page size'`.
   **Para corrigir um diagrama largo:** `direction TB` dentro do subgrafo só empilha se os nós tiverem
   arestas — nós soltos ficam lado a lado; ligue-os com o vínculo invisível `~~~` (`A ~~~ B ~~~ C`) e
   ligue os subgrafos entre si também com `~~~` (foi o que resolveu a figura 6.1). Alternativa mais
   simples: cadeia vertical (`flowchart TB`, `A --> B --> C`) com `width` reduzido na inclusão.
5. **`mmdc` sem navegador** falha com `Could not find chrome-headless-shell`. O
   `render-mermaid.sh` autodetecta o `google-chrome` via `--puppeteerConfigFile`.
6. **Listagens (`lstlisting`):** com o estilo `clp` cabem ~**70 caracteres** por linha. Linhas maiores
   quebram — e quebra em **desenho de Ladder em ASCII** destrói o alinhamento. Confira com
   `awk '/begin\{lstlisting\}/{i=1;next} /end\{lstlisting\}/{i=0} i&&length($0)>70'`.
7. **`circuitikz`:**
   - valor de rótulo com `=` interno precisa de chaves: `l={$R_{sh}=250\,\Omega$}`;
   - **comando de fonte dentro de `l=` quebra o parser** — use `font=\scriptsize` nas opções do
     ambiente;
   - `\\` dentro de um nó exige `align=center` (ou `left`);
   - `npn` **não** aceita `l=`; a chave `relais` **não existe** (use `L` para bobina e
     `closing switch` para contato);
   - rótulos longos se sobrepõem: posicione com `\node[left|right|below] at (x,y)`.
8. **`\and` não existe fora de `\author`** — a capa usa `\obraAutores` com `\\`.
9. **`makeindex` antes da 2ª passada**, senão o índice remissivo sai vazio (confira o tamanho de
   `build/apostila.ind`).

### Editar arquivo que já existe — leia com atenção

`create_file` **falha** em arquivo existente e `replace_string_in_file` **já reportou sucesso sem
aplicar** a edição. Para reescrever um arquivo, o caminho confiável é:

```bash
rm capitulos/22-seguranca-cibernetica.tex     # depois use create_file com o conteúdo completo
```

E **sempre confirme** que a edição chegou ao disco antes de compilar:
`grep -n "<trecho novo>" capitulos/22-seguranca-cibernetica.tex`.

---

## 4. Como está organizado o conteúdo

| Parte | Capítulos | Tema |
| --- | --- | --- |
| I | 1–4 | Fundamentos e projeto |
| II | 5–9 | Hardware e funcionamento |
| III | 10–16 | Programação e normas |
| IV | 17–23 | Integração e sistemas |
| V | 24–25 | Operação e carreira |
| Apêndices | A–D | Práticas de laboratório · guia de conversão legado → IEC · glossário · referências |

**Estrutura de um capítulo:**

```latex
\chapter{Título}          % sem número, sem caixa alta
\label{cap:algum-label}
\begin{objetivos} ... \end{objetivos}
\section{...}             % conteúdo, tabelas (booktabs) e figuras
\begin{pratica} ... \end{pratica}
\begin{exercicios} \begin{enumerate}[label=\alph*)] ... \end{enumerate} \end{exercicios}
```

Mais `\index{...}` em 2–4 pontos, `\begin{atencao}` para risco ou erro comum, e referências cruzadas
com `\ref{}` — **toda figura, tabela e listagem precisa ser citada no texto**, além de `\caption` e
`\label`. Cuidado com a sintaxe: é `\begin{enumerate}[label=\alph*)]`, **não**
`\begin[label=\alph*)]{enumerate}`.

Modelos prontos: `capitulos/13-iec-versus-legado.tex` (prosa e tabelas comparativas),
`capitulos/22-seguranca-cibernetica.tex` (normas com edição e ano),
`capitulos/apB-legado-para-iec.tex` (listagens lado a lado).

**Tabelas longas:** `longtable` com `\caption`/`\label` antes do `\toprule`, cabeçalho repetido com
`\endhead`, rodapé com `\endfoot` e fechamento com `\endlastfoot`. Modelos:
`apC-glossario.tex` e `apD-referencias.tex`.

---

## 5. Regras de conteúdo (da skill — não são sugestões)

1. **IEC 61131-3 versus legado é requisito explícito.** Todo tópico de linguagem/programação diz se é
   normatizado ou proprietário.
2. **Nunca invente número de seção da norma.** Cite edição e ano. Vigente: **4ª ed., maio de 2025**
   (IL depreciada na 3ª, 2013; removida na 4ª). Família até a parte 10. Se a edição não foi conferida,
   escreva que ela deve ser conferida no catálogo — foi o critério adotado no Apêndice D.
3. **Não prometa compatibilidade.** Diga "declarado conforme", "implementa o subconjunto".
4. **Consolide duplicatas do enunciado:** 13/23 (documentação) no Cap. 15; 12/20 (IoT-SCADA /
   análise de dados) nos Caps. 17 e 19, sem repetir conteúdo.
5. **Autores e instituição fixos** em capa, folha de rosto e metadados.
6. **Nada de capítulo órfão:** sem figura/tabela-exemplo, sem exercícios e sem entradas de índice,
   não passa no DoD.
7. `pdflatex` com `T1`/`utf8`/`babel brazil`; só use `xelatex`/`fontspec` se houver exigência
   tipográfica explícita.

### Direito autoral — regra que não se negocia

- **Nada da norma** (`docs/61131-3.pdf`): nem figura, nem trecho, nem número de seção. Serve para
  conferir fatos.
- **Figura de catálogo ou manual de fabricante** só entra com crédito explícito ("Fonte: ...").
  Prefira **redesenhar**. O `LICENSE.md` da obra ressalva esses casos.
- Ao mover figura herdada, confira o PDF original: figuras vetorizadas extraídas para Markdown viram
  grade de tabela e perdem o posicionamento.

---

## 6. O que resta: revisão do autor

Nada de implementação. As pendências estão detalhadas no §11 de `status.md`; em resumo:

1. **Leitura de terceiro** do texto publicado (recomendação do próprio Cap. 14).
2. **Figuras do legado**: as 97 originais não foram extraídas; as atuais são redesenhadas. Se quiser
   preservar uma foto de produto, extraia do PDF e credite.
3. **Conferência das edições marcadas como "conferir no catálogo"** no Apêndice D.
4. **Confirmação de coautoria** da `CLP_2023` como obra-fonte (já citada no Apêndice D).
5. **DOCX**, se for retomado: `pandoc` funciona (segue o `\input` dentro de `\chapterfile`), mas TikZ
   e `circuitikz` não convertem e os diagramas Mermaid precisam de PNG
   (`./scripts/render-mermaid.sh --png`).

---

## 7. Contexto que economiza tempo

- **`/memories/repo/apostila-clp-latex.md`** (memória de repositório) tem o resumo das armadilhas e
  dos fatos normativos verificados. Consulte antes de depurar algo que pareça novo.
- **Não reabra decisões do §5 de `status.md`** (estrutura, política de figuras, DOCX fora de escopo,
  nível).
- **As fontes de origem estão parcialmente corrompidas na conversão** (tabelas colapsadas). Tabela
  herdada **nunca** se copia do Markdown: leia no PDF original ou reescreva.
- **Recalcular a numeração**: qualquer inclusão de seção desloca páginas, figuras e tabelas. Depois de
  editar, reconfira o sumário (`build/apostila.toc`), a lista de figuras (`build/apostila.lof`) e a de
  tabelas (`build/apostila.lot`) — em especial a **sequência de legendas**, que denuncia figura
  perdida.

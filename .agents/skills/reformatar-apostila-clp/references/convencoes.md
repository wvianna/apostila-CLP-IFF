# Convenções, auditoria e critérios de aceite

## Checklist de auditoria do legado

Aplicar capítulo a capítulo e registrar o veredito em `apostila/INVENTARIO.md`.

- [ ] **Data e edição**: o material diz de quando é? Cita norma com edição/ano?
- [ ] **Norma desatualizada**: cita edição antiga da IEC 61131-3 (a 2ª ed. é de 2003; há a 3ª, de 2013)?
- [ ] **Lock-in de fabricante**: a nomenclatura e os mnemônicos são proprietários?
      (`XIC`, `XIO`, `OTL`, `OTU`, `JSR`, `BSL`, `BSR`, `MOV`, `CPT`, `SQR`, `NEG` → Allen-Bradley/RSLogix)
- [ ] **Mistura indevida**: operadores normatizados e mnemônicos de fabricante no mesmo texto sem aviso?
- [ ] **TOC**: numeração correta, sem linha de `.....` truncada, sem entrada órfã? (artefato do Word)
- [ ] **Referências cruzadas**: toda figura/tabela é citada no texto e tem `\label`?
- [ ] **Figuras**: legíveis, com fonte citada, atualizadas? Sobreviveram à conversão sem virar grade?
- [ ] **Exercícios**: existe exercício por capítulo? Tem resposta ou critério de correção?
- [ ] **Terminologia**: um único termo por conceito (ex.: "ciclo de varredura", não três sinônimos)?
- [ ] **Unidades**: SI, com vírgula decimal e prefixo correto (mA, ms, kΩ)?
- [ ] **Lacunas de conteúdo**: falta cibersegurança, IIoT/IoT, convergência TI/TO, eficiência
      energética, interoperabilidade, teste/simulação, documentação de programa?
- [ ] **Segurança do leitor**: algum procedimento ensina a mexer em máquina energizada sem bloqueio?
      (Se sim, corrija: procedimento de bloqueio antes de qualquer edição em campo.)
- [ ] **Idioma**: pt-BR consistente, acentuação correta, sem trecho residual em inglês sem tradução.

## Convenções editoriais

- Um conceito por seção; seção que passa de ~4 páginas sem figura, quebre.
- Título de seção em caixa alta apenas por estilo do template — no fonte, escreva em caixa mista.
- Numeração decimal para seções (`\section`, `\subsection`, `\subsubsection`); não numere manualmente.
- Listas: numeradas para **procedimentos**; com marcadores para **conjuntos**. Nunca misture na mesma lista.
- Sigla: expanda na primeira ocorrência com `\gls`-style manual (ex.: "Controlador Lógico Programável (CLP)").
- Toda afirmação normativa recebe referência: `\cite`/nota de rodapé com norma, edição e ano.
- Tabelas comparativas terminam em uma linha de conclusão no texto, não apenas na tabela.

## Convenções LaTeX

- `pdflatex` com `\usepackage[T1]{fontenc}`, `inputenc utf8`, `babel brazil`.
- Rótulos: `\label{cap:iot}`, `\label{sec:opcua}`, `\label{fig:arquitetura-scada}`,
  `\label{tab:iec-vs-legado}`, `\label{lst:ladder-partida}` — prefixo sempre.
- Referência sempre com `\ref{}`/`\autoref{}`; nunca "a figura acima".
- Figura: `\includegraphics[width=0.9\linewidth]` dentro de `figure` com `\caption` e `\label`.
- Tabela: `booktabs` (`\toprule`/`\midrule`/`\bottomrule`), sem linha vertical, `longtable` se passar
  de uma página. **Conte a largura**: cada coluna `p{x cm}` ocupa `x + 2\tabcolsep`, e o
  `\tabcolsep` do projeto é 3 pt. A soma das larguras `p{}` deve caber em ~14,6 cm (três colunas) ou
  ~14,3 cm (quatro colunas) para não transbordar a mancha. Tabela longa em `longtable` repete o
  cabeçalho com `\endhead` e fecha com `\endlastfoot`.
- Código: `lstlisting` com o estilo `clp` do template; listagem com mais de 20 linhas vai para
  `codigo/` e entra por `\lstinputlisting`.
- Diagrama mermaid: fonte `.mmd` versionada em `diagramas/`; o PDF gerado em `figuras/` é artefato.
  **Confira a proporção antes de compilar**: figura com proporção acima de ~3,5:1 fica ilegível em
  `width=\linewidth`; figura muito vertical precisa de `width` reduzido, senão o LaTeX acusa
  `Overfull \vbox`. Meça com `pdfinfo figuras/x.pdf`.
- Circuito: `circuitikz` no próprio `.tex` — nunca imagem colada quando for possível desenhar.
  Rótulo com sinal de igual interno vai entre chaves (`l={$R=1\,\text{k}\Omega$}`); comando de fonte
  não entra no valor de `l=`; `\\` em nó exige `align=`; posicione rótulos longos com
  `\node[left|right|below] at (x,y)` para não colidirem com o desenho.
- Capa/folha de rosto: use `\obraAutores` (separado por `\\`). Não introduza `\and` — ele só existe
  dentro de `\author`/`\maketitle` e quebra a capa do template.

## Definition of Done

- [ ] `apostila/apostila.pdf` compila **sem erro** e sem `??` de referência pendente.
- [ ] `grep -cE '^! |\.tex:[0-9]+: ' build/pass3.log` = 0.
- [ ] `grep -c undefined build/pass3.log` = 0.
- [ ] `grep -c 'Overfull .vbox' build/pass3.log` = 0 (nenhuma figura mais alta que a página).
- [ ] Nenhum texto desenhado acima da faixa do cabeçalho (caixa `tcolorbox` remanejada para o topo da
      página): `pdftotext -bbox apostila.pdf - | awk -F'"' '/<word / && $4+0 < 40' | wc -l` = 0.
      O cabeçalho fica em ~54,8 pt; qualquer valor abaixo de 40 pt é conteúdo fora de lugar.
- [ ] Nenhum `Overfull \hbox` acima de 5 pt (tabela ou listagem mais larga que a mancha).
- [ ] PDF tem `\tableofcontents` clicável + *bookmarks* por capítulo (índice interativo).
- [ ] Capa e folha de rosto trazem os três autores e o **Instituto Federal Fluminense**.
- [ ] Todos os capítulos da estrutura-alvo existem, um arquivo `.tex` cada, com `\include`.
- [ ] Todos os 28 requisitos cobertos conforme `references/estrutura.md`.
- [ ] Capítulo 13 (IEC 61131-3 vs. legado) existe, com tabela comparativa e Apêndice B preenchidos.
- [ ] Requisitos 13/23 (documentação) e 12/20 (IoT-SCADA / dados) consolidados, sem capítulo duplicado.
- [ ] Toda figura/tabela tem `\caption`, `\label` e citação no texto.
- [ ] Nenhuma figura ilegível (proporção acima de ~3,5:1 em `width=\linewidth`) e nenhum
      `Overfull \vbox` no log (figura mais alta que a página).
- [ ] Cada capítulo tem ao menos um exemplo prático aplicável e exercícios.
- [ ] Índice remissivo (`makeindex`) não está vazio.
- [ ] `apostila.docx` gerado, com limitações registradas (TikZ/listagens não convertem).
- [ ] Nenhuma norma citada com número de seção inventado; edição e ano sempre presentes.
- [ ] Nenhum procedimento incentiva trabalho em máquina energizada sem bloqueio.
- [ ] `INVENTARIO.md` e `PLANO.md` refletem o que foi de fato entregue.

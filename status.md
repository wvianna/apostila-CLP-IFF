# Status da nova apostila de CLP

**Data do snapshot:** 2026-09-24 (revisão do autor, lote 1)
**Produto:** `apostila/apostila.pdf` — **200 páginas**, 0 erro de TeX, 0 referência indefinida,
0 `Overfull \vbox`, nenhum `Overfull \hbox` acima de 5 pt
**Build atual:** `cd apostila && ./scripts/build.sh` (exit 0)
**Métricas:** 35 figuras, 68 tabelas, índice remissivo com 4.516 bytes

> **Decisão do autor (2026-09-22):** o `apostila.docx` não deve ser gerado nem editado. O produto é o
> PDF; a exportação DOCX fica fora do escopo deste ciclo.

**Estado do trabalho: todas as etapas de implementação estão concluídas.** O que resta é revisão do
autor (Seção 11).

---

## 1. Objetivo do projeto

Reformatar e atualizar a apostila de Controladores Lógicos Programáveis do **Instituto Federal
Fluminense** (Campus Campos dos Goytacazes, curso de Engenharia de Controle e Automação e Curso
Técnico em Automação Industrial), a partir de duas apostilas em PDF, em uma obra LaTeX única com
PDF e DOCX.

**Autores (fixos, em capa, folha de rosto e metadados):** M.Sc. Leonardo de Oliveira Tavares,
D.Sc. William da Silva Vianna, M.Sc. Natália Nogueira Monteiro.

**Requisitos do cliente:** 28 itens em `docs/skillbase.txt` — mapa de cobertura requisito → capítulo
em `.agents/skills/reformatar-apostila-clp/references/estrutura.md`.

---

## 2. Fontes

| Arquivo | Papel |
| --- | --- |
| `docs/Controladores Lógicos Programáveis - APOSTILA FINAL (TEORICA e PRATICA) - Rev 05D.pdf` | 105 p., Word 2016, 2017 (rev. 2021). **Fonte principal**; 29 figuras |
| `docs/CLP_2023.pdf` | 72 p., D.Sc. William da Silva Vianna. Fornece **hardware/E-S**, **SCADA** e **critérios de aquisição**; 68 figuras |
| `docs/61131-3.pdf` | A norma IEC 61131-3, **2ª ed. (2003)**, RC4. **Somente para conferência factual — não reproduzir** |
| `apostila/fontes/*.md` | Texto extraído das duas apostilas (insumo de trabalho, não é entrega) |

---

## 3. Progresso por lote

| Lote | Escopo | Estado |
| --- | --- | --- |
| 0 | Auditoria e plano | **Concluído** — `apostila/INVENTARIO.md`, `apostila/PLANO.md` |
| 1 | Parte I — caps. 1–4 (fundamentos e projeto) | **Concluído** |
| 2 | Parte II — caps. 5–9 (hardware e funcionamento) | **Concluído** |
| 3 | Parte III — caps. 10–16 (programação e normas) | **Concluído** |
| 4 | Parte IV — caps. 17–23 (integração e sistemas) | **Concluído** |
| 5 | Parte V — caps. 24–25 (operação e carreira) | **Concluído** |
| 6 | Apêndices A–D + fechamento | **Concluído** |

### Conteúdo entregue

**25 capítulos** em 5 partes — `01-introducao` · `02-evolucao-clps` · `03-estrutura-automacao` ·
`04-projeto-automacao` · `05-definicoes-caracteristicas` · `06-componentes-memoria` · `07-cartoes-es` ·
`08-porte-especificacao` · `09-principio-funcionamento` · `10-linguagens-programacao` ·
`11-iec61131-3-modelo` · `12-familia-iec61131` · `13-iec-versus-legado` · `14-boas-praticas` ·
`15-documentacao` · `16-simulacao-teste` · `17-redes-scada` · `18-iiot-opcua-mqtt` ·
`19-dados-tempo-real` · `20-interoperabilidade` · `21-convergencia-ti-to` · `22-seguranca-cibernetica` ·
`23-eficiencia-energetica` · `24-manutencao` · `25-formacao-continua`.

**4 apêndices:**

| Apêndice | Conteúdo |
| --- | --- |
| A — Práticas de laboratório | 11 práticas reescritas em IEC 61131-3, cada uma com objetivo, material, procedimento, critério de aceite e o que entregar; tabela de visão geral; regras de segurança do laboratório |
| B — Guia de conversão | Bits de status e parâmetros do legado; 11 casos com **código lado a lado** (legado × Ladder IEC × texto estruturado); tabela do que não converte mecanicamente; roteiro de conversão em 8 passos |
| C — Glossário | 85 termos em PT/EN com observação de uso e capítulo de referência, em `longtable` |
| D — Referências | Regras de citação; obras de origem; tabela de normas com **edição e ano conferidos**; bibliografia consolidada das duas apostilas, classificada em atual / histórica / pontual / fonte do dialeto |

---

## 4. Estrutura entregue

```text
apostila/
├── apostila.tex          # raiz (capa, partes, \chapterfile de cada capítulo)
├── capitulos/*.tex       # 29 arquivos: 25 capítulos + 4 apêndices
├── diagramas/*.mmd       # 27 fontes Mermaid versionadas
├── figuras/*.pdf         # figuras renderizadas (artefatos)
├── scripts/              # build.sh, extrair-fontes.sh, render-mermaid.sh
├── fontes/*.md           # texto extraído das fontes
├── build/                # artefatos de compilação
├── INVENTARIO.md         # auditoria do legado (etapa 1)
├── PLANO.md              # plano editorial e lotes (etapa 2)
└── apostila.pdf          # produto final
```

**Skill que executa o processo:** `.agents/skills/reformatar-apostila-clp/`
(SKILL.md + 3 references + template + 3 scripts).

---

## 5. Decisões já tomadas (não reabrir)

| Tema | Decisão |
| --- | --- |
| Estrutura da obra | 5 partes, 25 capítulos, 4 apêndices |
| Cap. 8 do legado (Allen-Bradley) | Reescrito em IEC 61131-3; o legado virou **Apêndice B** |
| Política de figuras | **Híbrida**: esquemas redesenhados (Mermaid/TikZ); foto/tela extraída do PDF com crédito |
| DOCX | **Fora de escopo** (decisão do autor em 2026-09-22): não gerar nem editar `apostila.docx` |
| `CLP_2023.pdf` | Incorporada como obra-fonte, citada no Apêndice D |
| Nível | Curso técnico, com caixas `Na prática` e blocos de aprofundamento nos capítulos avançados |
| Norma IEC | Citar sempre edição e ano; **nada reproduzido** da norma |

---

## 6. Fatos verificados que sustentam o texto

### Edições da IEC 61131-3 (verificado em fonte pública)

| Edição | Marco |
| --- | --- |
| 1ª, 1993 | Primeira publicação |
| 2ª, 2003 | A que as apostilas de origem usam: 5 linguagens (LD, FBD, IL, ST, SFC) |
| 3ª, 2013 | POUs orientadas a objeto; **deprecia a Lista de Instruções** |
| **4ª, maio de 2025** | **Vigente — removeu a Lista de Instruções** |

Família vai até a **parte 10**: 6 = segurança funcional · 9 = SDCI/IO-Link · 10 = XML de intercâmbio
(derivado dos esquemas da PLCopen). O material de origem cobre só 1–5, 7 e 8.

### Outros fatos verificados

- **IEC 61508** (segurança funcional, E/E/PE): 1ª edição 1998–2000, **2ª edição 2010**;
  **IEC 61511** é a aplicação para indústria de processo.
- **IEC 61499**: publicada em 2005; partes 1 e 2 em 2ª edição de 2012, parte 4 em 2ª edição de 2013;
  parte 3 retirada em 2008.
- **IEC 62443**: série da ISA99 com o grupo IEC TC65 WG10, publicada como ANSI/ISA 62443 e IEC 62443;
  norma horizontal. Papéis (proprietário do ativo, fornecedor, prestador de serviço), **zonas e
  condutos**, **SL 0–4**, níveis de maturidade 1–4. Partes com ano conferido: -1-1 (2009),
  -2-1 (2024), -2-4 (2023), -3-2 (2020), -3-3 (2013), -4-1 (2018), -4-2 (2019).
- **ISO/IEC 27001:2022** (3ª edição, out./2022; emenda de 2024) e **NIST CSF 2.0** (2024).
- **IEEE 754-2019** (julho de 2019), substituindo a edição de 2008; **ISO/IEC 60559:2020** com
  conteúdo idêntico.
- **OPC UA**: lançado em 2008 pela OPC Foundation; assinatura de dados, eventos, métodos, modelo de
  informação, PubSub e sessão segura com certificados X.509.
- **MQTT**: padrão da OASIS (versões 3.1.1 e 5.0), QoS 0/1/2 e sessão persistente. **Sparkplug**:
  especificação 3.0, mantida pela Eclipse Foundation.
- **Casos públicos** usados no Cap. 22: Stuxnet (2010); **CVE-2021-22681** (credencial/chave em
  controladores e ambiente de engenharia Logix, CVSS 3.1 base 9,8 no NVD — crítico, presente no
  catálogo de vulnerabilidades exploradas da CISA); **CVE-2022-1159** (injeção de código pelo Studio
  5000 Logix Designer, base 7,2 no NVD e 7,7 no ICS-CERT).
- **Histórico:** GM Hydramatic 1968 (especificação) → Bedford Associates/Modicon 084, 1969 (primeiro
  CLP) → Dick Morley; Odo Struger cunhou a sigla PLC na Allen-Bradley. O legado grafa "Hydromic".

### Correções aplicadas ao legado

Faixas de `DINT` e `UDINT`; `REAL` descrito como "precisão dupla" (é simples, 32 bits); "6 linguagens"
incluindo CFC (a norma define 5); "data do lendário" (calendário); "Fluminese" (Fluminense);
numeração furada no sumário e saltos de nível de título; na bibliografia, "MORAIES" (Moraes),
"Controladore" e "Éditora" corrigidos.

---

## 7. Defeitos de ferramental e de diagramação encontrados e corrigidos

Registrados aqui porque voltaram a acontecer e podem voltar:

1. **`build.sh` reportava 0 erros com 23 erros reais.** Com `-file-line-error` o TeX escreve
   `arquivo.tex:linha: msg`, não `! msg`. Sintoma: figura sumiu do PDF e o contador pulou de 7.3 para
   7.5. Corrigido (padrão duplo `^! |\.tex:[0-9]+:`).
2. **`mmdc` sem `--pdfFit`** gerava página Carta com o diagrama minúsculo no centro.
3. **`mmdc` sem navegador** falhava com "Could not find chrome-headless-shell"; o script agora
   autodetecta o `google-chrome`.
4. **`replace_string_in_file` reportou sucesso sem aplicar** a edição duas vezes. Contorno adotado:
   apagar o arquivo com `rm` e recriar.
5. **`siunitx` não instalado** — `\SI` quebra o build.
6. **Figura ilegível por proporção.** O `mmdc` recorta a página ao diagrama mas limita a largura a
   600 pt; diagrama muito largo é reduzido e a fonte encolhe junto. Quatro diagramas horizontais
   saíram com ~3 pt de fonte efetiva. Corrigidos por reestruturação do `.mmd` (subgrafos empilhados
   com o vínculo invisível `~~~`, ou cadeia vertical) e ajuste do `width`.
7. **`Overfull \vbox (... too high)` silencioso.** Três figuras — 6.1, 13.1 e 16.1 — eram mais altas
   que a página e transbordavam (até 844 pt), sem aparecer na contagem de erros.
8. **31 tabelas transbordavam a mancha (`Overfull \hbox`), também silencioso.** Causa: as larguras
   `p{}` foram somadas sem contar o `\tabcolsep` (cada coluna ocupa `x + 2\tabcolsep`). Com o padrão
   de 6 pt, uma tabela de 14,6 cm em três colunas mede 15,87 cm e passa dos 15,5 cm da mancha.
   Correção: `\setlength{\tabcolsep}{3pt}` no preâmbulo — resolveu 30 dos 31 casos — mais o ajuste da
   tabela do Cap. 2. Resultado: nenhum transbordo acima de 5 pt em 190 páginas.
9. **`Overfull \vbox` pré-existente na figura 14.1** (achado em 2026-09-24). O fluxograma do Cap. 14,
   incluído em `width=\linewidth`, mede 680 pt de altura contra 685,55 pt de mancha: somada a legenda,
   o float `[H]` transbordava 15,2 pt. Vinha do commit `633fef6` e **não** era efeito de nenhuma
   edição de texto — foi confirmado recompilando o commit `HEAD` em diretório limpo, que reproduz o
   mesmo transbordo. Correção: `width=0.95\linewidth`. Regra para diagrama vertical: altura natural ×
   `width` + legenda ≤ `\textheight`; meça com `pdfinfo figuras/x.pdf | grep 'Page size'`.

Os itens 6 a 8 entraram no *Definition of Done* da skill e na memória do repositório; o item 9 foi
registrado aqui em 2026-09-24.

---

## 8. Licenciamento e identidade (entregue em 2026-09-22)

A pedido do autor, foram aplicadas três alterações:

| Item | Onde |
| --- | --- |
| Curso de **Engenharia de Controle e Automação** somado ao Curso Técnico em Automação Industrial | `apostila/apostila.tex` — capa e folha de rosto (`\obraCursoEng`) |
| Licença **CC BY-SA 4.0** impressa na obra | folha de rosto (página 2 do PDF), com o resumo dos termos e o link do texto legal |
| Arquivos de licença e apresentação do repositório | `LICENSE.md` (termos + ressalvas sobre material de terceiros) e `README.md` |

A licença escolhida é **Creative Commons Atribuição–CompartilhaIgual 4.0 Internacional (CC BY-SA 4.0)**:
permite uso, adaptação e redistribuição, inclusive comercial, com atribuição e a mesma licença nas
obras derivadas. O `LICENSE.md` ressalva explicitamente que a licença **não** cobre figura de catálogo
de fabricante nem texto normativo. O Apêndice D retoma a regra no que se refere a citação de normas.

---

## 9. Verificação do fechamento (Lote 6)

| Verificação | Resultado |
| --- | --- |
| `./scripts/build.sh` | exit 0, 3 passadas com 0 erro de TeX |
| `grep -cE '^! \|\.tex:[0-9]+: ' build/pass3.log` | 0 |
| `grep -c undefined build/pass3.log` | 0 |
| `grep -c 'Overfull .vbox' build/pass3.log` | 0 |
| `Overfull \hbox` acima de 5 pt | 0 (eram 31 antes da correção) |
| Sumário | 30 entradas de capítulo (25 capítulos + 4 apêndices + índice remissivo) |
| Índice remissivo | 4.228 bytes, com entradas novas (`glossário`, `conversão de código`, `prática de laboratório`, `bibliografia`, `referências normativas`) |
| Estrutura dos 4 apêndices | `objetivos`, `pratica`, `atencao`, `exercicios` e `\index` presentes em todos |
| Figuras, tabelas e listagens citadas no texto | todas com `\ref` |
| Conferência visual | 20+ páginas inspecionadas em imagem (figuras dos caps. 6, 13, 16 a 25; páginas dos apêndices A a D; tabelas longas do glossário e da lista de normas) |

---

## 10. Uso do material

```bash
cd apostila
./scripts/build.sh              # PDF: 200 páginas (não usar --docx)
./scripts/render-mermaid.sh     # diagramas/*.mmd -> figuras/*.pdf
```

---

## 11. Pendências em aberto

Nenhuma pendência de implementação. As que restam dependem do autor:

1. **Revisão humana do texto publicado** — os 25 capítulos e os 4 apêndices não passaram por leitura
   de terceiro (o checklist do Cap. 14 recomenda; aqui não foi aplicado).
2. **Figuras do legado não recuperadas** — as 97 figuras originais (29 + 68) não foram extraídas; as
   figuras atuais são **redesenhadas**. Se o autor quiser preservar alguma foto de produto, ela precisa
   ser extraída do PDF com crédito. As três figuras acrescentadas em 2026-09-24 vieram da pasta
   `figuras/` do próprio repositório e estão sem linha de "Fonte:": se alguma não for de autoria do
   autor, o crédito precisa ser acrescentado.
3. **Confirmação de coautoria** da `CLP_2023` como obra-fonte citada (já registrada no Apêndice D).
4. **Conferência das edições das normas marcadas como "conferir no catálogo"** no Apêndice D — partes
   da IEC 61131-1, -2, -4, -5, -6, -7, -8, -10; IEC 61511; ISO/IEC 17065 e ISO/IEC 17025. O texto não
   faz afirmação técnica que dependa dessas edições, mas a lista ficaria mais completa com elas.
5. **Exportação DOCX** — fora de escopo por decisão do autor; se for retomada, o caminho já verificado
   é `pandoc` (que segue o `\input` dentro de `\chapterfile`), com as limitações conhecidas: TikZ e
   `circuitikz` não convertem.

---

## 12. Revisão do autor — lote 1 (2026-09-24)

Seis ajustes pedidos pelo autor, aplicados sobre a obra fechada. O PDF passou de 197 para **200
páginas**. (A linha de base registrada em 2026-09-22 tinha 190 páginas; os commits `03beecf` e
`48d44fa`, de figuras, acrescentaram material depois daquele snapshot.)

| # | Pedido | O que foi feito |
| --- | --- | --- |
| 1 | Cap. 3, abertura: "não é apenas um controlador ligado a sensores" | frase completada com "e atuadores/elementos finais de controle" (`03-estrutura-automacao.tex`) |
| 2 | Trocar a figura 3.1 pela imagem fornecida | `03-piramide-niveis.jpeg` (a partir de `figuras/figura3-1.jpeg`) substituiu o diagrama mermaid `03-piramide-automacao.pdf`; legenda mantida |
| 3 | Cap. 7.3 — texto sobre *sourcing* e *sinking* e figura das ligações de entrada e saída | nova subseção **7.3.1 Lógica positiva e negativa: *sinking* e *sourcing***, com a figura **7.4** (`07-sourcing-sinking.jpeg`) e nota sobre o duplo sentido dos termos |
| 4 | Página 49 — texto sobre as ligações de E/S e figura | nova subseção **7.5.1 Resumo das ligações de entrada e de saída**, com a figura **7.7** (`07-di-do.jpeg`) e o texto do autor sobre os seis arranjos (entrada CC *sinking*/*sourcing*, entrada CA, saída CC *sinking*/*sourcing* e saída a relé), fechada por caixa de atenção sobre a falta de uniformidade da nomenclatura entre fabricantes |
| 5 | Cap. 9 — rotina de inicialização antes do ciclo de varredura | a antiga 9.3 passou a ser **9.1**; "O ciclo de varredura" virou 9.2 e as demais seções deslizaram para 9.3 a 9.6; a lista de objetivos foi reordenada para acompanhar |
| 6 | Cap. 10 — exemplos das linguagens | nova subseção **10.3.1 Exemplos comparados**, com a figura **10.2** (`10-exemplos-linguagens.jpeg`) |

Numeração de figuras depois das mudanças: **7.1 a 7.7** (antes 7.1 a 7.5) e **10.1 a 10.3** (antes
10.1 a 10.2); as demais séries não mudaram. Nenhuma figura é citada por número fixo no texto — todas
usam `\ref{}` —, de modo que a renumeração é automática.

O diagrama mermaid `03-piramide-automacao.mmd` e o PDF gerado `figuras/03-piramide-automacao.pdf`
continuam no repositório, mas não são mais incluídos na obra: ficam como alternativa vetorial, caso o
autor queira voltar ao diagrama anterior.

Verificação final: 200 páginas, 0 erro de TeX, 0 referência indefinida, 0 `Overfull \vbox`, 0
`Overfull \hbox` acima de 5 pt, 0 `Underfull \vbox`, 0 palavra desenhada acima da mancha. Conferência
visual das páginas das figuras novas (22, 48, 51 e 70) e da figura 14.1.

**Decisão pendente:** as três figuras novas vieram da pasta `figuras/` do repositório e estão sem
linha de "Fonte:". Se alguma não for de autoria do autor, o crédito precisa ser acrescentado — o
`LICENSE.md` ressalva que a licença CC BY-SA 4.0 não cobre material de terceiros.

# Plano editorial

Etapa 2 da skill `reformatar-apostila-clp`. Deriva do `INVENTARIO.md` (etapa 1).

> **GATE:** este plano precisa de aprovação do autor antes de começar a redação (etapa 3).

## 1. Resultado-alvo

Uma apostila única em LaTeX, em `apostila/`, compilada em PDF (índice interativo) e exportável para
DOCX, com:

- 5 partes, 25 capítulos e 4 apêndices, todos com exemplo prático e exercícios;
- diferenciação explícita entre **CLP conforme IEC 61131-3** e **CLP legado/proprietário**;
- ~97 figuras resolvidas entre redesenhadas (Mermaid/TikZ) e recuperadas do PDF com crédito;
- capa e folha de rosto com os três autores e o **Instituto Federal Fluminense**.

## 2. O que muda em relação ao legado (decisões de fundo)

| # | Mudança | Por quê |
| --- | --- | --- |
| M1 | **Norma antes do dialeto de fabricante** | O legado ensina `XIC`/`JSR` depois de apresentar a norma, sem mapa de conversão (achado B3) |
| M2 | **Cap. 8 do legado deixa de ser capítulo e vira Apêndice B** | É dialeto Allen-Bradley/RSLogix, não IEC 61131-3 (achado B1/B2) |
| M3 | **"6 linguagens" → 5 linguagens**; CFC tratada como extensão | Erro factual verificado na norma (achado A1) |
| M4 | **IL passa a ser apresentada como depreciada**, não como ponto de partida | 3ª edição da norma (achado A2) |
| M5 | **Toda afirmação normativa cita edição e ano** | Achado A4 |
| M6 | **Tabelas são reescritas, nunca copiadas do Markdown** | Conversão colapsou todas as tabelas (§2.3 do inventário) |
| M7 | **Exercícios em todos os capítulos** | Requisito 2; nenhuma das fontes tem exercícios (achado D7) |
| M8 | **Numeração antiga → nova é publicada** (§5) | A renumeração invalida referências de ementa e plano de aula |
| M9 | **Capítulos novos nascem da bibliografia já existente** | A Rev 05D cita IIoT, visão computacional e IEC/TC65 (2015–2017) mas não os desenvolve (achado C) |

## 3. Estrutura final e origem de cada capítulo

Legenda de origem: **A** = Rev 05D · **B** = CLP_2023 · **N** = novo.

| # | Capítulo | Origem | Insumo concreto | Veredito |
| --- | --- | --- | --- | --- |
| | **PARTE I — FUNDAMENTOS E PROJETO** | | | |
| 1 | Introdução e importância da automação | A+B | A cap. 1.1; B cap. 2.1–2.4 | reescrever enxuto |
| 2 | Evolução dos CLPs: do relé ao controle em nuvem | A+B | A cap. 1.2 (GM/Morley, 10 requisitos); B cap. 2.2–2.3 | atualizar + linha do tempo |
| 3 | A estrutura da automação | A | A cap. 2 (pirâmide, 5 níveis, IoT/OPC/MES/PIMS) | atualizar |
| 4 | Projeto de automação industrial | A | A cap. 3 (P&ID, lista de I/O, descritivo, planta, arquitetura) | manter + atualizar |
| | **PARTE II — HARDWARE E FUNCIONAMENTO** | | | |
| 5 | Definições, características e aplicações | A+B | A 4.1–4.3; B 2.1, 2.4 | fundir |
| 6 | Componentes, memória e tipos de dados | A+B | A 4.4–4.5 (IEEE-754, mapa, cálculo); B 3.1–3.2 | fundir (B é mais rica) |
| 7 | Cartões de E/S, resolução e instalação | A+B | A 4.6–4.7 (cartões, resolução); B 3.3.1 (características de E-S) | fundir — **seção mais ilustrada** |
| 8 | Porte, redundância e especificação para compra | A+B | B cap. 9 (**exclusivo**: classificação por porte, aspectos técnicos e contratuais); A 4.8 | manter + atualizar |
| 9 | Princípio de funcionamento, ciclos e estados | A+B | A cap. 5; B cap. 3.1.1–3.1.4 e 4 | fundir |
| | **PARTE III — PROGRAMAÇÃO E NORMAS** | | | |
| 10 | Linguagens de programação (LD, FBD, IL, ST, SFC) | A+B | A cap. 6; B cap. 5–6 e 7 (endereçamento ED/EA/SD/SA/A) | atualizar + corrigir A1/A2 |
| 11 | IEC 61131-3 em profundidade: POUs, tipagem, tarefas | A+B | A 7.3 (configuração/recurso/tarefa/POU); B 6.7 | reescrever em parte |
| 12 | Família IEC 61131 e o entorno (PLCopen, 61499, OPC UA) | A | A cap. 7 (partes 1–5, 7, 8 — **acrescentar parte 6**) | atualizar |
| 13 | **CLP conforme IEC 61131-3 vs. CLP legado** | A+B | A cap. 8 + B 6.7; mapa `XIC→LD`, `XIO→LDN`, `OTL/OTU→SET/RESET`, `BSL/BSR→SHL/SHR`, `JSR→chamada de POU`, `CPT→expressão ST` | **reescrever (requisito 10)** |
| 14 | Boas práticas e padronização de código | N | — | novo |
| 15 | Documentação de programas de CLP | N | A cap. 3 tem a base documental do projeto | novo |
| 16 | Simulação, teste e comissionamento virtual | N | — | novo |
| | **PARTE IV — INTEGRAÇÃO E SISTEMAS** | | | |
| 17 | Redes industriais e sistemas SCADA | B+A | B cap. 8 (local, I/O remoto, rede de CLPs); A cap. 2 (níveis, protocolos) | manter + atualizar |
| 18 | IIoT, OPC UA e MQTT | A(refs)+B | A cap. 2 + refs 2015–2016 (Sasajima; Hwang); B cap. 8 | novo |
| 19 | Dados, telemetria e monitoramento em tempo real | N | A cap. 2 (MES/PIMS, manutenção preditiva) | novo |
| 20 | Interoperabilidade entre marcas e modelos | N | insumo direto do Cap. 13 | novo |
| 21 | Convergência TI/TO (visão computacional, SLM, plugins, Node-RED, MATLAB, Linux embarcado) | A(refs)+N | A refs: "Machine Vision in IIoT" (2016) | novo |
| 22 | Segurança cibernética em automação industrial | N | A 7.2 (interferências, testes) e 7.4 (IEC 61508/61511) | novo |
| 23 | Eficiência energética e sustentabilidade | N | A 1.1 (redução de consumo como benefício da automação) | novo |
| | **PARTE V — OPERAÇÃO E CARREIRA** | | | |
| 24 | Manutenção preventiva e corretiva | N | A 1.2 (manutenção de painéis a relé) e 4.9 | novo |
| 25 | Formação contínua, certificações e recursos | N | B cap. 10 (bibliografia) | novo |

### Apêndices

| Apêndice | Conteúdo | Origem |
| --- | --- | --- |
| A — Práticas de laboratório | Exercícios reescritos em IEC (o legado tem prática só em dialeto) | A cap. 8 reformulado |
| B — **Guia de conversão legado ↔ IEC 61131-3** | Tabela de mnemônicos → operadores normatizados | A cap. 8 |
| C — Glossário | PT/EN com o termo da norma | ambas |
| D — Referências normativas e bibliografia | união das duas bibliografias, atualizada | A + B |

## 4. Balanço de esforço

| Situação | Capítulos |
| --- | --- |
| Migram com ajuste (fonte pronta) | 1, 3, 4, 5, 6, 7, 9, 10, 12 |
| Migram com reescrita parcial | 2, 8, 11, 17 |
| Reescrita de fato (conteúdo mal classificado) | 13 |
| **Novos (sem material de base)** | **14, 15, 16, 18, 19, 20, 21, 22, 23, 24, 25 — 11 capítulos** |

Ou seja: **44 % do índice (11 de 25 capítulos) não tem material de base nas fontes atuais.**

## 5. Tabela de correspondência antigo → novo (para ementa e plano de aula)

| Antigo | Novo |
| --- | --- |
| Rev 05D 1 / CLP_2023 2 | Caps. 1–2 |
| Rev 05D 2 | Cap. 3 |
| Rev 05D 3 | Cap. 4 |
| Rev 05D 4.1–4.3 / CLP_2023 2 | Cap. 5 |
| Rev 05D 4.4–4.5 / CLP_2023 3.1–3.2 | Cap. 6 |
| Rev 05D 4.6–4.7 / CLP_2023 3.3 | Cap. 7 |
| Rev 05D 4.8 / CLP_2023 9 | Cap. 8 |
| Rev 05D 5 / CLP_2023 3.1, 4 | Cap. 9 |
| Rev 05D 6 / CLP_2023 5, 6, 7 | Cap. 10 |
| Rev 05D 7.3 / CLP_2023 6.7 | Caps. 11–12 |
| Rev 05D 8 | Cap. 13 + Apêndices A e B |
| CLP_2023 8 | Cap. 17 |
| — | Caps. 14–16, 18–25 (novos) |

## 6. Lotes de execução

Cada lote termina compilando (`scripts/build.sh`), sem erro de TeX, com figuras no lugar.

1. **Lote 1 — Parte I** (caps. 1–4): migração e enxugamento da prosa do legado.
   **CONCLUÍDO (2026-09-22).** 4 capítulos escritos, 4 diagramas Mermaid renderizados,
   `apostila.pdf` com 54 páginas, 0 erro de TeX e 0 referência indefinida. O esqueleto dos 25
   capítulos + 4 apêndices existe como arquivos `.tex` com aviso explícito de "em elaboração",
   para o PDF ficar coerente entre lotes.
2. **Lote 2 — Parte II** (caps. 5–9): maior volume de figuras (E-S e memória). Depende da decisão
   sobre recuperação de figuras (§7, pendência 2).
   **CONCLUÍDO (2026-09-22).** 5 capítulos escritos, 5 diagramas Mermaid e 3 circuitos `circuitikz`
   (entrada optoacoplada, saída a relé, shunt de 250\,$\Omega$), `apostila.pdf` com 80 páginas.
   Achado relevante no caminho: o `build.sh` reportava "0 erro" com 23 erros reais no log, porque
   `-file-line-error` não usa o prefixo `!` — corrigido no script.
3. **Lote 3 — Parte III** (caps. 10–16): inclui o **cap. 13 e o Apêndice B**, o núcleo do requisito 10.
   **CONCLUÍDO (2026-09-22).** 7 capítulos escritos; `apostila.pdf` com 112 páginas, 0 erro de TeX e 0
   referência indefinida. A pendência 1 foi resolvida por verificação em fonte pública: a edição
   vigente é a **4ª (maio de 2025)** — IL depreciada em 2013 e **removida em 2025** —, e o XML de
   intercâmbio é a **parte 10** da família.
4. **Lote 4 — Parte IV** (caps. 17–23): em grande parte escrita nova.
   **CONCLUÍDO (2026-09-22).** 7 capítulos escritos; `apostila.pdf` com 161 páginas, 0 erro de TeX,
   0 referência indefinida e 0 `Overfull \vbox`. Fatos normativos novos conferidos em fonte pública
   antes da redação: série IEC 62443 (zonas/condutos, SL 0–4, maturidade, partes e anos),
   ISO/IEC 27001:2022, NIST CSF 2.0, IEC 61508 (2ª ed. 2010) e IEC 61511, OPC UA, MQTT (OASIS),
   Sparkplug 3.0 e os casos públicos CVE-2021-22681 e CVE-2022-1159. Nada foi reproduzido da norma.
   Achado de diagramação: 4 diagramas com proporção acima de 8:1 saíam ilegíveis em `width=\linewidth`
   (o `mmdc` limita a página a 600 pt) e 3 figuras (cap. 6, 13 e 16) estouravam a altura da página —
   todas corrigidas; a regra entrou na skill.
5. **Lote 5 — Parte V** (caps. 24–25): escrita nova.
   **CONCLUÍDO (2026-09-22).** 2 capítulos escritos e compilados junto com o Lote 4 (161 páginas,
   0 erro). O Cap. 24 fechou as referências pendentes de `cap:manutencao` (caps. 5, 6 e 23) e o
   Cap. 25 referencia a trilha, as certificações e o plano de 90 dias.
6. **Lote 6 — Fechamento**: apêndices C e D, índice remissivo, revisão do DoD, PDF e DOCX.
   Apêndices A, B, C e D seguem como esqueleto. O DOCX **não** deve ser gerado nem editado
   (decisão do autor, 2026-09-22); o produto é o PDF.
   **CONCLUÍDO (2026-09-22).** 4 apêndices escritos: práticas de laboratório reescritas em
   IEC 61131-3 (11 práticas, com critério de aceite), guia de conversão com **código lado a lado**
   em 11 casos mais a tabela de bits de status e a dos pontos que não convertem mecanicamente,
   glossário PT/EN com 85 termos em `longtable`, e bibliografia consolidada com a tabela de normas
   por edição e ano. `apostila.pdf` com **190 páginas**, 0 erro de TeX, 0 referência indefinida,
   0 `Overfull \vbox` e nenhum `Overfull \hbox` acima de 5 pt. Achado relevante: **31 tabelas de
   toda a obra transbordavam a mancha** por não contabilizar o `\tabcolsep` — corrigido no preâmbulo
   e a regra entrou na skill.

Trilha paralela, ao longo de todos os lotes: recuperação/redesenho das 97 figuras.

## 7. Pendências que dependem do autor (gate)

1. **Edição da norma. RESOLVIDA (2026-09-22).** Verificado em fonte pública: 1ª ed. 1993, 2ª ed. 2003,
   3ª ed. 2013 (POUs orientadas a objeto; IL depreciada) e **4ª ed. maio de 2025 (vigente; IL
   removida)**. Os capítulos 11 e 12 citam edição e ano, e o cap. 10 registra a depreciação e a
   remoção da Lista de Instruções. Nada foi reproduzido da norma.
2. **Política de figuras.** Redesenhar as 97 (melhor qualidade e sem risco autoral, mais lento) ou
   recuperar do PDF as que forem fotografias/telas e redesenhar só esquemas? *Recomendação: híbrido —
   redesenhar todo esquema/diagrama; recuperar do PDF apenas foto de produto e tela de IDE, sempre com
   crédito "Fonte:".*
3. **Incorporação da CLP_2023.** Ela é de outro autor (D.Sc. William da Silva Vianna, também autor da nova
   obra). Confirmar que o texto dela pode ser **incorporado e modificado** na nova apostila — e se
   deve ser citada como obra-fonte no Apêndice D.
4. **Nível de profundidade.** Manter o foco em **curso técnico** ou admitir aprofundamento de
   engenharia nos capítulos novos (ex.: SLM/edge, IEC 62443)? *Recomendação: manter nível técnico,
   com bloco "Para aprofundar" nos capítulos mais avançados.*
5. **Aprovação do plano** para iniciar a redação do Lote 1.

## 8. Critérios de aceite (o DoD da skill, aplicado)

- [ ] `apostila/apostila.pdf` compila sem erro, sem `??`, com sumário clicável e *bookmarks*.
- [ ] 25 capítulos + 4 apêndices presentes, um arquivo `.tex` cada.
- [ ] Os 28 requisitos do enunciado cobertos (mapa em `references/estrutura.md`).
- [ ] Cap. 13 + Apêndice B resolvem o requisito 10 (IEC × legado) com tabela comparativa.
- [ ] Requisitos 13/23 (documentação) e 12/20 (IoT-SCADA / dados) consolidados, sem duplicata.
- [ ] Toda figura/tabela com `\caption`, `\label` e citação no texto.
- [ ] Exercícios em todos os capítulos.
- [ ] Nenhuma tabela copiada do Markdown sem conferência no PDF.
- [ ] Nenhuma afirmação normativa sem edição e ano.
- [ ] Nenhuma figura ou trecho reproduzido da norma IEC.
- [ ] Índice remissivo não vazio.
- [ ] `apostila.docx` gerado.
- [ ] Tabela de correspondência antigo → novo publicada (§5).

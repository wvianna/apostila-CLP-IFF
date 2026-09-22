# Estrutura-alvo da obra

Proposta de reorganização da apostila. Ajuste em `PLANO.md` e confirme com o usuário antes de redigir.

## Princípios de reorganização

1. **Duas metades explícitas:** teoria/hardware primeiro, programação/integração depois. O legado
   intercala (o capítulo de linguagens vem antes da norma que as define).
2. **Norma antes da prática vendor-specific.** O legado ensina `XIC`/`JSR` antes de explicar
   IEC 61131-3 — inverta: primeiro o modelo normatizado, depois o mapa para o dialeto legado.
3. **Toda parte fecha com prática:** laboratório, exercícios e checklist de verificação.
4. **Interoperabilidade, cibersegurança e documentação são capítulos, não apêndices.**
5. **Um capítulo por requisito temático**, com as duplicatas do enunciado consolidadas.

## Estrutura proposta

| # | Capítulo | Origem principal | Requisito |
| --- | --- | --- | --- |
| | **PARTE I — FUNDAMENTOS E PROJETO** | | |
| 1 | Introdução e importância da automação | Rev05D cap. 1 | — |
| 2 | Evolução dos CLPs: do relé ao controle em nuvem | Rev05D 1.2; CLP_2023 2.2–2.3 | 14 |
| 3 | A estrutura da automação | Rev05D cap. 2 | — |
| 4 | Projeto de automação industrial (P&ID, lista de I/O, descritivo, arquitetura) | Rev05D cap. 3 | — |
| | **PARTE II — HARDWARE E FUNCIONAMENTO** | | |
| 5 | Definições, características e aplicações do CLP | Rev05D 4.1–4.3 | — |
| 6 | Componentes, memória e tipos de dados (binário, complemento de dois, IEEE-754) | Rev05D 4.4–4.5 | — |
| 7 | Cartões de E/S, resolução, calibração e instalação | Rev05D 4.6–4.7 | — |
| 8 | Porte, redundância e **especificação para compra** | Rev05D 4.8; CLP_2023 cap. 9 | — |
| 9 | Princípio de funcionamento, ciclos e estados de operação | Rev05D cap. 5; CLP_2023 cap. 4 | — |
| | **PARTE III — PROGRAMAÇÃO E NORMAS** | | |
| 10 | Linguagens de programação e o modelo IEC 61131-3 (LD, FBD, IL, ST, SFC) | Rev05D cap. 6; CLP_2023 cap. 5–6 | — |
| 11 | IEC 61131-3 em profundidade: POUs, tipagem, tarefas, configuração, OOP | Rev05D 6.2–6.5 | — |
| 12 | Família IEC 61131 e o entorno (PLCopen, IEC 61499, OPC UA) | Rev05D cap. 7 | — |
| 13 | **CLP conforme IEC 61131-3 vs. CLP legado** | Rev05D cap. 8 (reclassificado) | 10 |
| 14 | Boas práticas e padronização de código | novo | 11, 18 |
| 15 | Documentação de programas de CLP | novo | 13, 23 |
| 16 | Simulação, teste e comissionamento virtual | novo | 22 |
| | **PARTE IV — INTEGRAÇÃO E SISTEMAS** | | |
| 17 | Redes industriais e sistemas SCADA | CLP_2023 8.1; Rev05D 4.2 | 12 |
| 18 | IIoT, OPC UA e MQTT: CLP conectado | novo | 12 |
| 19 | Dados, telemetria e monitoramento em tempo real | novo | 20 |
| 20 | Interoperabilidade entre marcas e modelos | novo | 19 |
| 21 | Convergência TI/TO: visão computacional, SLM, plugins, Node-RED, MATLAB, Linux embarcado | novo | 24 |
| 22 | Segurança cibernética em automação industrial | novo | 16 |
| 23 | Eficiência energética e sustentabilidade | novo | 21 |
| | **PARTE V — OPERAÇÃO E CARREIRA** | | |
| 24 | Manutenção preventiva e corretiva | novo | 17 |
| 25 | Formação contínua, certificações e recursos | novo | 15 |

### Apêndices

- **A — Práticas de laboratório** (migrar exercícios do cap. 8 do legado, reescritos em IEC).
- **B — Guia de conversão legado ↔ IEC 61131-3** (tabela de mnemônicos → operadores normatizados).
- **C — Glossário** (PT/EN, com o termo padronizado pela norma).
- **D — Referências normativas e bibliografia.**

## Mapeamento requisito → capítulo (cobertura total)

| Req. | Tema | Capítulo |
| --- | --- | --- |
| 1 | Analisar/identificar desatualizado | Etapa 1 (`INVENTARIO.md`) |
| 2 | Estrutura, exemplos, exercícios | Todos (Partes I–V, Apêndice A) |
| 3 | Atualização técnica | Cap. 2, 12, 18, 21 |
| 4 | Arquivo final formatado | `apostila.tex` + build |
| 5 | PDF e DOCX | Etapa 5 |
| 6 | Índice interativo | `hyperref` (template) |
| 7 | Títulos/listas consistentes | `references/convencoes.md` |
| 8 | Imagens/diagramas/tabelas referenciados | Etapa 4 |
| 9 | Gerar diagramas novos | Etapa 4 |
| 10 | IEC 61131-3 vs. legado | Cap. 13 + Apêndice B |
| 11 | Boas práticas, segurança, eficiência | Cap. 14 |
| 12 | IoT e SCADA | Cap. 17, 18 |
| 13 | Documentação de programas | Cap. 15 |
| 14 | Evolução dos CLPs | Cap. 2 |
| 15 | Formação contínua | Cap. 25 |
| 16 | Segurança cibernética | Cap. 22 |
| 17 | Manutenção preventiva/corretiva | Cap. 24 |
| 18 | Padronização de código | Cap. 14 |
| 19 | Interoperabilidade | Cap. 20 |
| 20 | Análise de dados / tempo real | Cap. 19 |
| 21 | Sustentabilidade e eficiência energética | Cap. 23 |
| 22 | Simulação e teste | Cap. 16 |
| 23 | Documentação (duplicata do 13) | Cap. 15 |
| 24 | Convergência TI/TO | Cap. 21 |
| 25 | Ilustrações didáticas | Etapa 4 |
| 26 | LaTeX em `apostila/` compilado | Etapas 3 e 5 |
| 27 | Autores | Capa/folha de rosto (template) |
| 28 | Instituto Federal Fluminense | Capa/folha de rosto (template) |

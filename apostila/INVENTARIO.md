# Inventário e auditoria das fontes

Etapa 1 da skill `reformatar-apostila-clp`. Base para o `PLANO.md` (etapa 2).

Data da auditoria: 2026-09-22.
Escopo: as duas apostilas de CLP em `docs/`. A norma `docs/61131-3.pdf` foi usada apenas para
conferência factual (ver §2), não como fonte de conteúdo.

---

## 1. Fontes analisadas

| Arquivo | Págs. | Autor(es) | Gerador / data | Imagens embutidas | Figuras citadas | Extração |
| --- | --- | --- | --- | --- | --- | --- |
| `Controladores Lógicos Programáveis - APOSTILA FINAL (TEORICA e PRATICA) - Rev 05D.pdf` | 105 | M.Sc. Leonardo de Oliveira Tavares; M.Sc. Natália Nogueira Monteiro | Word 2016; criado 2017, rev. 2021 | 504 objetos | **29** (Figura 1–29) | limpa (anydoc) |
| `CLP_2023.pdf` | 72 | D.Sc. William da Silva Vianna (IFF) | LibreOffice 24.2 | 185 objetos | **68** (Figura 1–68) | limpa (anydoc) |
| `61131-3.pdf` | 226 | IEC (norma) | 2003, 2ª edição, PDF RC4 | 3 | — | **não extraída** (§2) |

Os três autores exigidos pelo projeto já aparecem nas fontes: M.Sc. Leonardo de Oliveira Tavares e
M.Sc. Natália Nogueira Monteiro na Rev 05D; D.Sc. William da Silva Vianna na CLP_2023. Os textos são complementares e **não se
sobrepõem integralmente**: a Rev 05D é mais forte em linguagens/norma; a CLP_2023 é mais forte em
hardware/E-S, SCADA e **critérios de aquisição de CLP** (cap. 9), que não existem na outra.

## 2. O que a extração preservou e o que se perdeu

1. **Texto: preservado.** As duas apostilas têm camada de texto; a conversão saiu limpa, com títulos
   e hierarquia mantidos (nenhuma precisou de OCR).
2. **Imagens: perdidas.** Os Markdown saíram com **0 imagens** — as 29 figuras da Rev 05D e as 68 da
   CLP_2023 não vieram. Toda ilustração precisa ser recuperada do PDF ou redesenhada (§6).
3. **Tabelas: colapsadas.** Não há uma tabela Markdown sequer nos dois arquivos. Onde havia tabela, o
   texto virou blocos de células embaralhadas. Exemplos reais:
   - Rev 05D, cap. 7.3: a tabela de tipos de dados saiu como `|Bit Strings|LINT-long integer (8 byte)|…`
     com as colunas trocadas;
   - Rev 05D, cap. 8.2.2: a explicação do TON saiu como
     `|quando|timer_1.tt timer_1.dn enquanto o|…`, ilegível;
   - CLP_2023, cap. 3.3.1 e 8.1: idem.
   **Consequência prática: nenhum trecho de tabela pode ser copiado do Markdown — tem de ser lido no
   PDF original e reescrito.**
4. **Norma não extraída (decisão deliberada).** `61131-3.pdf` não foi convertida para Markdown e não
   deve ser reproduzida: é obra normativa protegida. Uso permitido na prática: **conferir fatos** e
   citar edição/ano. Nenhuma figura ou trecho da norma entra na apostila.
   (Foi assim que se verificou o achado A1 abaixo.)

## 3. Inventário — Rev 05D (105 p., 8 capítulos)

| Cap. | Título | Conteúdo | Figuras | Veredito | Destino |
| --- | --- | --- | --- | --- | --- |
| 1 | Introdução | Importância da automação; histórico (relés → GM/Morley) | — | **reescrever** | Caps. 1 e 2 |
| 2 | A estrutura da automação | Pirâmide da automação, 5 níveis, menções a IoT/IIoT/OPC/MES | ~4 | **atualizar** | Cap. 3 (e insumo para 17–18) |
| 3 | Projeto de automação industrial | P&ID, lista de I/O, descritivo operacional, planta baixa, arquitetura | ~4 | **manter + atualizar** | Cap. 4 |
| 4 | Estudo e definições gerais sobre CLP | Definição, memória, tipos de dados, IEEE-754, mapa de memória, cartões de E-S, resolução, porte, redundância, software | ~31 | **manter + atualizar** | Caps. 5–8 |
| 5 | Princípio de funcionamento | Varredura, estados de operação | ~2 | **atualizar** | Cap. 9 |
| 6 | Linguagens de programação | As 5 linguagens, tasks, tipagem, modularização | — | **atualizar** | Cap. 10 |
| 7 | Norma IEC 61131 | Partes 1–5, 7 e 8 da norma; conceitos (configuração, recurso, tarefa, POU) | 1 | **reescrever em parte** | Caps. 11–12 |
| 8 | Prática – programação | Instruções e blocos de função **Allen-Bradley/RSLogix** (8.2.1 a 8.2.7) | — | **reescrever** | Cap. 13 + Apêndice B |
| — | Referências | 20 itens (1992–2017), muitos `s.d.` | — | **atualizar** | Apêndice D |

## 4. Inventário — CLP_2023 (72 p., 10 capítulos)

| Cap. | Título | Conteúdo | Figuras | Veredito | Destino |
| --- | --- | --- | --- | --- | --- |
| 1–2 | Introdução / Informações gerais | Características, breve histórico, evolução, aplicações | ~12 | **atualizar** | Caps. 1–2, 5 |
| 3 | Estrutura básica | Microprocessador (cíclico, interrupção, tempo, evento), memória, mapa, E-S (seção 3.3.1, a mais densa), terminal de programação | ~46 | **manter** (núcleo forte) | Caps. 6–7, 9 |
| 4 | Princípio de funcionamento | Estados de operação, funcionamento | ~4 | **fundir** com Rev 05D cap. 5 | Cap. 9 |
| 5 | Linguagem de programação | Classificação (baixo/alto nível) | — | **fundir** | Cap. 10 |
| 6 | Programação de controladores | LD, FBD, IL, ST, SFC, análise comparativa, **6.7 Normalização IEC 61131** | ~9 | **atualizar** | Caps. 10–11, 13 |
| 7 | Programação em Ladder | Endereçamento (ED/EA/SD/SA/A), desenvolvimento, instruções básicas | ~25 | **atualizar** (manter abordagem de endereçamento) | Cap. 10 + Apêndice A |
| 8 | Noções de SCADA com uso do CLP | Arquitetura de rede: local, I/O remoto/distribuído, rede de CLPs | ~4 | **manter + atualizar** | Cap. 17 |
| 9 | Critérios para aquisição de um CLP | Classificação por porte (Micro ≤64, Pequeno ≤256, Médio ≤1024, Grande ≤4096, Muito Grande >4096 E-S); especificação; análise de fornecedor; aspectos técnicos e contratuais | — | **manter** (conteúdo exclusivo e valioso) | Cap. 8 |
| 10 | Bibliografia recomendada | 5 itens (1992–2008) | — | **substituir** | Apêndice D |

## 5. Achados de auditoria

### A. Erros factuais e desatualização de norma (corrigir)

- **A1 — "6 linguagens" inclui CFC, que não é da norma.** Rev 05D, cap. 7.3 lista
  "Texto Estruturado (ST), Lista de Instruções (IL), Ladder (LD), Blocos Funcionais (FBD),
  Sequenciamento (SFC)" e acrescenta "**Funções Gráficas Contínuas (CFC) – extensão da IEC 61131-3**",
  totalizando 6. **Verificação factual no próprio sumário da norma** (`docs/61131-3.pdf`): a norma
  define **5 linguagens** — IL (§3.2), ST (§3.3), SFC (§2.6), LD (§4.2) e FBD (§4.3). **CFC não consta
  da norma**; é extensão de ambiente de programação. Corrigir para 5 linguagens e tratar CFC como
  extensão, não como norma.
- **A2 — IL está depreciada.** O cap. 6 do legado apresenta a Lista de Instruções como linguagem de
  primeira classe. A 3ª edição da norma (2013) marcou IL como *deprecated* em favor de ST. O novo
  texto deve dizer isso explicitamente, em vez de ensinar IL primeiro.
- **A3 — Falta a parte 6 da família 61131.** O cap. 7 cobre as partes 1, 2, 3, 4, 5, 7 e 8. A
  **parte 6 (segurança funcional)** ficou de fora — justificável em 2003 (não existia), mas é lacuna
  hoje e é pré-requisito do cap. 22 (cibersegurança/segurança).
- **A4 — Norma citada sem edição.** O texto trata "IEC 61131-3" como referência atemporal. Precisa
  qualificar edição/ano sempre. Estado **verificado em fonte pública** (artigos IEC 61131 e IEC
  61131-3, com remissão ao *webstore* da IEC): 1ª ed. 1993; 2ª ed. 2003; 3ª ed. 2013 (descreve POUs
  orientadas a objeto e **deprecia a Lista de Instruções**); **4ª ed. maio de 2025, vigente, que
  removeu a Lista de Instruções**. A família chega à parte 10 — a 6 é segurança funcional, a 9 é
  SDCI/IO-Link e a 10 é o formato XML de intercâmbio, derivado dos esquemas da PLCopen.
- **A5 — Imprecisão no histórico.** Rev 05D, cap. 1.2: abre dizendo "surgiram em **1969**" e logo
  depois narra a especificação da GM em "**1968**", sob "Richard (Dick) Morley". As duas datas
  convivem (especificação × primeira entrega), mas o texto não explica — confunde o aluno. Também
  grafa a divisão da GM como "**Hydromic** Division" (a forma consagrada é Hydra-Matic). Conferir e
  explicitar.
- **A6 — Tipificação com erro de digitação.** Rev 05D, cap. 7.3, tabela de tipos: "`DATE` – **data do
  lendário**" (leia-se "data do calendário"). Corrigir.
- **A7 — Bibliografia defasada.** Rev 05D: acessos datados de 28/10/2017, vários `s.d.`, um link para
  a Wikipedia; CLP_2023: 1992–2008. Nenhuma referência posterior a 2017 em nenhuma das duas.

### B. Lock-in de fabricante (o achado mais relevante — requisito 10)

- **B1 — Cap. 8 inteiro em dialeto Allen-Bradley/RSLogix**, sem aviso ao leitor:
  `XIC`, `XIO`, `OTE`, `OTL`, `OTU`, `ONS`, `OSR`, `OSF`, `TON`, `TOF`, `BSR`, `JSR`, além de `MOV`,
  `CPT`, `SQR`, `NEG`. Não há nenhum operador normatizado (`LD`, `AND`, `OR`, `TON` da norma) no
  capítulo.
- **B2 — A dependência está confessada na própria bibliografia**: a referência usada para o capítulo é
  "**Rockwell Automation. (2001). Controladores Logix5000 – Manual de Referência Geral do Conjunto de
  Instruções**". O capítulo ensina um produto, não a norma.
- **B3 — Consistência interna quebrada**: o cap. 6 apresenta as 5 linguagens da norma e o cap. 7 diz
  que a norma existe "para que os CLP's de diferentes fabricantes possam ser utilizados por programas
  distintos" — e o cap. 8 seguinte contradiz isso ao ensinar exclusivamente o dialeto de um
  fabricante. **A ordem também está invertida**: ensina-se o dialeto depois de apresentar a norma,
  mas sem mapa de conversão.
- **B4 — CLP_2023, cap. 7 é mais equilibrado**, mas ainda usa endereçamento `ED/EA/SD/SA/A` específico
  de um fabricante sem declarar de qual.

### C. Lacunas de conteúdo (requisitos 11–24)

Ausentes nas duas fontes, como capítulo: segurança cibernética industrial · IIoT/OPC UA/MQTT ·
análise de dados e monitoramento em tempo real · interoperabilidade entre marcas · convergência
TI/TO (visão computacional, SLM, plugins, Node-RED, MATLAB, Linux embarcado) · eficiência energética
e sustentabilidade · manutenção preventiva/corretiva · simulação e teste antes da implantação ·
documentação de programa como entrega de engenharia · formação contínua e certificações.

**Nuance importante:** a Rev 05D **já menciona** IoT/IIoT, OPC, MES e PIMS de passagem no cap. 2, e a
bibliografia já inclui artigos de 2015–2016 sobre IIoT e **visão computacional**
("Machine Vision in IIoT", 2016; IEC/TC65, 2015; Hwang et al., 2016 sobre difusão de IoT). Ou seja:
**a bibliografia é mais atual que o corpo do texto** — esses capítulos novos podem nascer das
referências que já estavam na apostila, devidamente atualizadas.

### D. Defeitos de forma e edição

- **D1 — Sumário quebrado**: as linhas de `......` estão truncadas e a numeração tem salto — o próprio
  sumário lista "**4.8.4.** Redundância por Software e Hardware" sem existir 4.8.1 a 4.8.3.
- **D2 — Numeração de títulos inconsistente**: convivem `## 1.`, `# 1.1.`, `### 3.1.1.` e
  `#### 8.2.1.1.` — níveis de heading trocados (artefato do Word).
- **D3 — Erro de grafia no cabeçalho da CLP_2023**: o rodapé imprime "Instituto Federal
  **Fluminese**-IFF" (leia-se **Fluminense**).
- **D4 — Tabelas chamadas de "Figura"**: "**Figura 29** – Partes da Norma IEC 61131" é uma tabela.
  Corrigir a classificação (figura × tabela × quadro).
- **D5 — Divisores de página no meio do texto** (`______`) separando frases, herdados do Word.
- **D6 — Prosa introdutória vaga** (cap. 1: "caminho sem volta", "estamos sempre evoluindo") que
  ocupa páginas sem entregar conteúdo técnico. Enxugar.
- **D7 — Sem exercícios** em nenhuma das duas apostilas. O requisito 2 pede exercícios por capítulo.

### E. Figuras (maior esforço de recuperação)

- **97 figuras** entre as duas fontes (29 + 68), **nenhuma** recuperada na conversão.
- Concentração: CLP_2023 cap. 3.3.1 (características de E-S) e cap. 7.1 (ladder) são as seções mais
  ilustradas; Rev 05D tem o bloco pesado em cartões de E-S (4.6) e memória (4.5).
- Vários PDFs têm mais objetos de imagem que figuras citadas (504 e 185): no PDF do Word as figuras
  costumam vir **fatiadas em vários pedaços**, então a extração bruta não devolve a figura inteira.
- Várias figuras são **de catálogo de fabricante** (há uma creditada "Fonte: Catálogo WEG") e o cap. 8
  é de manual de instruções Rockwell → **reuso exige crédito e cuidado de direito autoral**.

### F. Riscos

1. **Direito autoral** — três frentes: figuras de catálogo/manual de fabricante, a norma IEC (não
   reproduzir) e terceiros. Mitigação: **redesenhar** esquemas e diagramas; manter foto de produto
   apenas com crédito explícito; nunca reproduzir figura ou trecho da norma.
2. **Perda de precisão na migração** — fórmulas e tabelas de resolução de E-S, cálculo de memória e
   IEEE-754 precisam ser conferidas no PDF, não copiadas do Markdown (ver §2.3).
3. **Rastreabilidade** — como o material é usado em curso técnico, a numeração nova (5 partes/25
   capítulos) invalidará referências de ementa/plano de aula. Precisa de uma **tabela de
   correspondência antigo → novo** publicada no plano.

## 6. Situação das figuras e plano de recuperação

| Faixa | Origem | Estratégia |
| --- | --- | --- |
| Diagramas de bloco, arquitetura, pirâmide, fluxo, mapa de memória, TI/TO | Rev 05D e CLP_2023 | **Redesenhar em Mermaid** (versionável, nítido, sem direito autoral) |
| Circuitos elétricos, botoeira/selo, partida de motor, E-S optoacoplada | ambas | **Redesenhar em TikZ + `circuitikz`** |
| Tela de IDE, ladder impresso, produto físico, foto de painel | ambas | **Extrair do PDF** como PNG (`pdfimages -png` / `pdftoppm`), usar como imagem; se for de catálogo, creditar "Fonte:" |
| Tabelas (tipos de dados, resolução, lista de I/O, classificação por porte) | ambas | **Reescrever como `tabular`/`longtable`** com `booktabs` (não são figuras) |
| Qualquer figura da norma IEC | `61131-3.pdf` | **Não usar** — redesenhar do zero a partir do conceito |

## 7. Insumos aproveitáveis das próprias fontes

- **Rev 05D** — núcleo de memória/tipos/E-S/resolução (cap. 4), conceitos da norma (7.3) e a lista de
  referências de IIoT/visão computacional de 2015–2017.
- **CLP_2023** — cap. 3 (processamento e memória com 46 figuras de referência), cap. 9 (aquisição:
  classificação por porte + aspectos técnicos e contratuais) e cap. 8 (arquitetura SCADA local,
  I/O remoto e rede de CLPs), além do endereçamento do cap. 7.
- **Nenhuma das duas** tem exercícios ou projeto de documentação → tudo isso é capítulo novo.

## 8. Conclusão da etapa

Nenhuma das duas apostilas foi feita para ser descartada: **as duas se somam**, e a soma ainda deixa
dez capítulos inteiramente em branco. O maior ganho imediato não é escrever conteúdo novo, é
**reclassificar o cap. 8 do legado** (requisito 10) e **recuperar as 97 figuras**, hoje perdidas na
conversão.

# Tópicos novos — pontos obrigatórios

Para cada tópico: o que **não pode faltar**, as normas/base de referência e as armadilhas.
Nunca invente número de seção de norma: cite edição e ano.

## Cap. 2 — Evolução dos CLPs (req. 14)

- Linha do tempo: painéis de relé → CLP modular (1968, necessidade da indústria automotiva) → CLP
  compacto/PAC → CLP com Ethernet industrial → controlador com virtualização/edge.
- O que mudou em cada salto: densidade de I/O, ciclo de varredura, linguagens, conectividade,
  diagnóstico, custo por ponto.
- Diferencie **CLP, PAC e controlador de segurança** (não são sinônimos).
- Feche com tabela "geração → característica → limitação".

## Cap. 13 — CLP conforme IEC 61131-3 vs. legado (req. 10) — **capítulo obrigatório**

- O que a norma define: modelo de software (configuração → recurso → tarefa → POU), tipos de dados
  elementares e derivados, e as 5 linguagens (LD, FBD, IL, ST, SFC).
- O que a norma **não** define: endereçamento de E/S físico, IDE, protocolo de rede, presença de
  temporizadores específicos — por isso "compatível" precisa de qualificação.
- Tabela comparativa obrigatória:

  | Aspecto | Conforme IEC 61131-3 | Legado proprietário |
  | --- | --- | --- |
  | Linguagens | LD/FBD/IL/ST/SFC padronizadas | mnemônicos do fabricante |
  | Exemplos reais de mnemônicos | `LD`, `AND`, `OR`, `TON`, `CTU`, `MOV` | `XIC`, `XIO`, `OTL`, `OTU`, `JSR`, `BSL`, `BSR`, `CPT` (Allen-Bradley/RSLogix) |
  | Portabilidade | código migra entre IDEs conformes | preso ao fabricante |
  | Tipagem | forte, derivada padronizada | tipagem própria |
  | Reuso | POUs, funções, blocos | rotinas/sub-rotinas do IDE |

- Apêndice B fecha o mapa `XIC ↔ contato NA`, `XIO ↔ contato NF`, `OTL/OTU ↔ SET/RESET`,
  `JSR ↔ chamada de POU`, `BSL/BSR ↔ SHL/SHR`, `CPT ↔ expressão em ST`.
- Diga o estado atual: IL foi **depreciada** na 3ª edição (2013) e **removida** na 4ª edição (maio de
  2025, vigente) — não ensine IL como primeira linguagem. XML de intercâmbio é a parte 10 da família
  (esquemas da PLCopen), não a edição da parte 3.

## Cap. 14 — Boas práticas e padronização (req. 11, 18)

- Convenção de nomes de tags (prefixo por tipo/área, verbo-substantivo, sem acento/caractere especial).
- Estrutura de programa: separar por área/máquina, uma responsabilidade por POU, evitar lógica
  duplicada, usar blocos de função em vez de copiar código.
- Segurança funcional e de processo dentro da lógica: intertravamento, partida segura, tratamento de
  falha, *watchdog*, limite de tempo de ciclo, o que **não** pode estar só no software.
- Eficiência: reduzir varredura (saídas antecipadas, tarefas eventuais), uso correto de retentivas,
  tratamento de primeira varredura e de retomada após queda de energia.
- Cite uma convenção de estilo de referência (ex.: PLCopen/ISA-88 para organização física) sem
  inventar seções.
- Fechar com "checklist de revisão de código" (revisável em campo).

## Cap. 15 — Documentação de programas (req. 13 e 23 — **duplicata consolidada**)

- Artefatos mínimos de entrega: descritivo de arquitetura, lista de I/O, tabela de tags, diagrama de
  fluxo/sequência, listagem comentada, manual de operação, plano de backup/versionamento.
- **Exemplo real obrigatório**: um bloco documentado linha a linha + uma tabela de tags preenchida.
- Versionamento: o que versionar (fonte do projeto, não só PDF), rotina de backup, gestão de
  alteração ("o que mudou depois do comissionamento").
- Documentação como requisito contratual de entrega — amarra com o Cap. 8 (especificação e compra).
- Modelo preenchível, não teoria.

## Cap. 16 — Simulação e teste antes da implantação (req. 22)

- Escada de validação: revisão de lógica → simulação de I/O no IDE → soft-PLC → teste com I/O
  simulado → **HIL** (hardware-in-the-loop) → comissionamento com *dry-run*.
- Ferramenta de soft-PLC/emulação: diga claramente que cada IDE traz seu simulador e que a
  portabilidade do simulado depende de o código ser conforme (amarra com Cap. 13).
- Testes que precisam existir antes de energizar: intertravamento, emergência, partida, retomada,
  comportamento em falha de rede.
- Monte um roteiro de teste em tabela (caso → estímulo → resultado esperado → evidência).

## Cap. 17 — Redes industriais e SCADA (req. 12, parte 1)

- Hierarquia de níveis (campo → controle → supervisão → gestão) e o que trafega em cada um.
- Protocolos de campo e industriais (Modbus RTU/TCP, Profibus/Profinet, EtherNet/IP, CANopen, HART)
  com uma linha de "uso típico" cada — sem extrapolar especificação técnica que não se possa verificar.
- Arquitetura SCADA: servidor de dados, IHM, histórico (*historian*), alarmes e eventos, relatórios.
- Leitura de alarme × evento × intertravamento (evitar o erro clássico de tratar alarme como proteção).

## Cap. 18 — IIoT, OPC UA e MQTT (req. 12, parte 2)

- Por que OPC UA resolve o que Modbus não resolve: modelo de informação, tipos, sessão segura.
- MQTT e *publish/subscribe* em telemetria: broker, tópicos, QoS, e o papel do Sparkplug B na
  padronização do payload.
- Padrões e desafios: latência, determinismo, custo de rede, *store and forward*, borda vs. nuvem.
- Vantagens e desafios explícitos (o requisito pede os dois lados).

## Cap. 19 — Análise de dados e monitoramento em tempo real (req. 20)

- Do dado bruto ao indicador: OEE, disponibilidade, tempo de ciclo, contagem, consumo energético.
- Onde processar: no CLP, no edge ou na nuvem — critério de decisão (latência × volume × criticidade).
- Tendência, histórico, detecção de desvio e manutenção preditiva simples (limite, taxa de mudança,
  contagem de ciclos).
- Deixe claro o limite: o CLP faz a leitura rápida e o intertravamento; análise pesada vai para fora.

## Cap. 20 — Interoperabilidade entre marcas (req. 19)

- Estratégias: norma IEC 61131-3 + biblioteca padronizada (PLCopen) + código estruturado em
  blocos portáveis; e a alternativa pragmática de tradução entre IDEs.
- Onde a portabilidade realmente quebra: endereçamento físico, funções de sistema, blocos de
  comunicação proprietários, temporizadores específicos, HMI/SCADA acoplado.
- Protocolo aberto como ponte (OPC UA, Modbus TCP) quando o código não é portável.
- Tabela de risco de migração por marca é opcional; **não** afirme compatibilidade entre fabricantes
  sem fonte verificável.

## Cap. 21 — Convergência TI/TO (req. 24)

Pontos obrigatórios, um por subtema:

1. **Visão computacional e processamento de imagem**: captura (GigE/USB), bibliotecas (OpenCV),
   inspeção (presença, dimensão, leitura de código), e quando roda no CLP vs. num PC/IPC de borda.
2. **SLM em CLPs** (*small language models*): o que cabe no hardware do controlador hoje (modelos
   pequenos/inferência leve), casos de uso viáveis (ajuda ao operador, diagnóstico assistido, geração
   de relatório) e o que é irrealista (inferência pesada no ciclo de varredura). Seja explícito sobre
   latência, memória e o risco de colocar IA dentro do laço de controle.
3. **Plugins no CLP/IDE**: extensibilidade por add-in, marketplace do fabricante, impacto na
   portabilidade e no ciclo de validação.
4. **Node-RED**: integração visual de fluxo, uso em borda, *gateway* de protocolo, prototipagem;
   deixe claro que **não** substitui lógica determinística de segurança.
5. **MATLAB/Simulink**: geração de código para controlador, teste de algoritmo antes de embarcar,
   limites do código gerado no ambiente de tempo real.
6. **Linux em sistemas embarcados e CLPs**: por que distribuições Linux (e variantes RT/preempt)
   viraram base de IPC/controlador; trade-off entre flexibilidade e determinismo/certificação.
7. **Fechamento**: tabela "o que ganha / o que perde / o que exige" ao trazer cada tecnologia TI para TO.

## Cap. 22 — Segurança cibernética (req. 16)

- Diferença entre segurança funcional (*safety*) e segurança cibernética (*security*) — o material
  precisa dizer isso uma vez, com clareza.
- Base normativa: **IEC 62443** (zonas, condutos, níveis de garantia), **ISO/IEC 27001** para o lado
  corporativo; NIST CSF como referência de programa.
- Superfície de ataque do CLP: engenharia/IDE, OPC UA, painel web, USB, rede flat, firmware sem
  assinatura, credenciais padrão.
- Contramedidas concretas: segmentação por zona/conduto, *firewall* industrial, VPN, autenticação,
  desabilitar serviços não usados, controle de mídia removível, *hardening* de IHM, registro/backup.
- Incidente e resposta: plano de contingência, modo manual seguro, restauração a partir de backup
  confiável. Cite ao menos um caso público de ataque a instalação industrial (sem detalhar exploração).

## Cap. 23 — Eficiência energética e sustentabilidade (req. 21)

- Como a lógica afeta o consumo: parada/desligamento automático, setpoint ótimo, ajuste por demanda,
  eliminação de operação a vazio, tempo de espera.
- Medição: medidor de energia, tags de kWh, indicadores por linha/turno.
- Controle de demanda, partida de motores, controle de bomba/ventilador por curva e por variador
  de frequência.
- Ciclo de vida e *e-waste*: escolha por vida útil, atualização sem troca total, descarte.

## Cap. 24 — Manutenção preventiva e corretiva (req. 17)

- Modos de falha típicos: bateria de retenção, cartão de E/S, fonte, acúmulo de calor/poeira,
  corrupção de programa, rede instável.
- Rotina preventiva: backup do projeto, inspeção térmica/limpeza, ventilação, teste de bateria,
  conferência de I/O, leitura de diagnóstico do controlador.
- Diagnóstico por sintoma → causa → verificação (tabela), incluindo: "saída não atua" (força forçada,
  cartão queimado, lógica não satisfeita), "entrada não lê" (sinal, campo, filtro, tensão de
  alimentação), "CLP em *fault*" (fonte, módulo, programa).
- Arrancada/parada: procedimento antes de mexer no programa em máquina em produção.
- Manutenção preditiva como evolução (contagem de ciclos, degradação, temperatura).

## Cap. 25 — Formação contínua (req. 15)

- Trilha sugerida: eletricidade/comandos elétricos → lógica digital → CLP conforme IEC 61131-3 →
  redes industriais → supervisão/SCADA → integração e segurança.
- Certificações e treinamentos existentes (fabricantes e entidades de formação; cite nomes reais,
  sem prometer validade ou preço).
- Recursos: simuladores gratuitos, normas, documentação de fabricante, comunidades, projetos de
  bancada própria.
- Incluir um plano de estudo de 90 dias, em tabela, para o aluno do curso técnico.

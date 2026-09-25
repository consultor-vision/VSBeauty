# Inventário — Conversão FlutterFlow → React (VSB)

Pacote original: `original/lovable_conversion_final_2026-09-25.zip`
(MD5 `1c7be30866155d419b6fd2bbd298d6dc`). Os dois ZIPs enviados eram idênticos; apenas um foi guardado.
Conteúdo extraído: `lovable_conversion_final/` (somente referência — não é compilado nem usado pelo app).

## Conteúdo
| Tipo | Qtde | Situação |
|---|---|---|
| Páginas (`src/pages`) | 10 | Apenas "cascas": lista de textos + TODO |
| Componentes (`src/components`) | 70 | Cascas com textos visíveis + TODO |
| Models (`src/models`) | 70 | Tipos de estado do FlutterFlow |
| Custom functions | 22 | Mistas: algumas funcionais, várias quebradas |
| `project_config/pubspec.yaml` | 1 | Dependências Flutter (referência) |
| `project_config/firestore_indexes.json` | 1 | Vazio (projeto usa Supabase) |
| `conversion_manifest.json` | 1 | 102 mapeamentos Dart → TSX |

## Dependências
- Pacote convertido: `react`, `react-dom`, `@supabase/supabase-js`, `vite`, `typescript` (todas `latest`) — **já existem no projeto**; nada foi instalado.
- Flutter (pubspec): go_router, fl_chart, supabase/gotrue, file_picker, google_fonts, etc. Sem equivalente necessário: o app atual já usa react-router, recharts, Supabase e upload próprio.

## TODOs encontrados (86 arquivos)
- 70× "Map FlutterFlow actions and Supabase queries…" (todos os componentes)
- 10× "Replace this migration shell…" (todas as páginas)
- 6× "Replace this adapter…" (custom functions)

## Problemas
1. **Pasta `extracted_code/` (código Dart) ausente no ZIP**, embora o README e o manifesto a referenciem 102 vezes. Sem ela, as regras de negócio originais não podem ser conferidas.
2. As páginas/componentes não têm lógica nem layout — são inferiores ao sistema atual.
3. `textoParaDouble` usa variável inexistente (`texto`) — não compila.
4. `calcularLucro`, `calcTotalPlano` e outras lançam "Manual conversion required".
5. `supabase.ts` próprio usa `VITE_SUPABASE_ANON_KEY` e navegação por `useState` — incompatíveis; o app deve continuar usando o cliente, rotas e autenticação existentes.
6. Acentos corrompidos (ex.: "GestÃ£o") — codificação errada na extração.
7. `MenuGestao` do FlutterFlow tem o item **"Atendimento APP"**, que não existe no Gestão atual.

## Piloto Gestão — mapeamento
| FlutterFlow | Gestão atual (`src/pages/Gestao.tsx`) |
|---|---|
| MenuGestao | Menu de visões (colaborador…contas_receber) |
| NovoColaborador / EditarColaborador / GColab*Popover | Visão Colaborador (já com gravação) |
| NovoProcedimento / EdicaoProcedimento | Visão Procedimento |
| NovaPergunta / EditarPergunta / CMP*Anamnese | Visão Anamnese |
| ANovoEstoque / AEditarEstoque / BNovoProduto / CEditarProduto(s) | Visão Estoque (vw_estoque_atual) |
| ContaPagar / EditarContaPagar / Categoria* / Item* / ContasPagar*Popover | Visão Contas a Pagar |
| EditarRecebido / DescricaoRecebimento | Visão Contas a Receber |
| (Atendimento APP) | **Não existe — aguardando definição** |

Funções portadas e testadas: `src/lib/flutterflow/gestao-functions.ts`
(somarValores, somarValoresContaReceber, ptbrToDouble, textoParaDouble).

## Testes pendentes
- Comparar telas Gestão com o app FlutterFlow em produção (sem o Dart, só visualmente).
- Testar gravações do Gestão com usuário real de homologação (duas companhias, isolamento).
- Conversão de calcularLucro/calcTotalPlano quando o código Dart for enviado.

# Inventário — Migração FlutterFlow → React (VSB)

## Pacotes originais (preservados em `original/`)
| Arquivo | MD5 | Conteúdo |
|---|---|---|
| `lovable_conversion_final_2026-09-25.zip` | `1c7be308…d6dc` | Só a conversão (1ª importação) |
| `lovable_homologacao_package_full_2026-09-25.zip` | `42a33d59…c821` | Conversão + `flutterflow_source` (Dart) |

## Estrutura
- `lovable_conversion_final/` — conversão React/TS. A pasta `conversion/` do pacote completo é **idêntica** (diff vazio), por isso não foi duplicada.
- `flutterflow_source/` — fonte Dart/FlutterFlow original, sem alterações (inclui 70 componentes, 22 custom functions, páginas e `flutterflow_all_code.txt`).
- `PACOTE_README.md` — README do pacote completo.
Nada desta pasta é compilado (fora de `tsconfig` e ignorado no ESLint).

## Convertido e integrado ao app
| Item | Destino | Situação |
|---|---|---|
| 22 custom functions | `src/lib/flutterflow/custom-functions.ts` | Port fiel ao Dart, testado |
| Funções do Gestão | `src/lib/flutterflow/gestao-functions.ts` | Reexporta os ports + `totaisPorStatus` |
| Totais Contas a Pagar/Receber | `src/pages/Gestao.tsx` | Antes eram valores fixos de exemplo; agora somam dados reais por status Pago/Pendente/Atrasado (regra do `gestao.dart`) |

## Correções
- `textoParaDouble` (variável inexistente), `calcularLucro`, `calcTotalPlano`, `calcularHoraFim`, `criarDataHora` ("Manual conversion required") e adaptadores que retornavam `undefined`: reescritos a partir do Dart.
- `ptbrToDouble` anterior não seguia o Dart ("1,234.56"); corrigido.
- Acentuação: "MarÃ§o" → "Março" (aceita as duas formas).

## Decisões
- Páginas/componentes convertidos são cascas sem lógica; as telas atuais do VSB (Agenda, Cadastro, Evolução, Gestão, Analytics, Login) já cobrem as funções e foram mantidas.
- "Atendimento APP" (Menu_Gestao): no original só aparece para usuário `id == 0` e abre a visão Estoque — é um atalho provisório, não uma função nova. Não foi replicado.
- Filtro por mês dos totais do FlutterFlow: a tela atual não tem seletor de mês; os totais consideram todos os lançamentos da companhia.

## Testes pendentes
- Conferir os totais do Gestão com dados reais de homologação (duas companhias).
- Comparar visualmente com o app FlutterFlow em produção.

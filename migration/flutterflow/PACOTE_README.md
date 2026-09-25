# Pacote VSB para homologação

Este pacote contém:

- `conversion/`: conversão estrutural Dart/FlutterFlow para React/TypeScript.
- `flutterflow_source/`: arquivos extraídos do FlutterFlow, preservados como fonte de referência.

Regras de integração:

- Trabalhar somente na branch `homologacao`.
- Não substituir o `src` atual inteiro.
- Integrar por módulo, começando por Gestão.
- Não criar novas tabelas ou colunas no Supabase sem validação.
- Não publicar em produção.

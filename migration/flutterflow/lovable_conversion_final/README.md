# Conversão FlutterFlow para Lovable

Esta pasta contém uma primeira conversão estrutural do código FlutterFlow/Dart para React + TypeScript, formato que o Lovable consegue ler e continuar editando.

## Resultado

- Componentes React: 70
- Páginas React: 10
- Funções TypeScript: 22
- Configurações preservadas: `project_config/pubspec.yaml` e `project_config/firestore_indexes.json`

## Limite importante

FlutterFlow gera Dart/Flutter e o Lovable trabalha principalmente com React/TypeScript. Não existe uma conversão literal segura para todos os widgets, consultas, estados e ações. Por isso, cada `.tsx` contém a estrutura React, props detectadas, textos visíveis e pontos de integração marcados com `TODO`. As regras originais continuam disponíveis em `extracted_code`.

Antes de publicar no GitHub, configure as variáveis `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` no Lovable e revise as funções marcadas para adaptação manual.

# Features

Cada funcionalidade do app (Auth, Feed, Sermons) deve ser um diretório aqui.

## Estrutura Padrão

- **domain**: Entidades, UseCases e Contratos de Repositório (camada mais interna, sem dependências de Flutter ou bibliotecas externas se possível).
- **data**: Modelos, DataSources (API/DB) e Implementação dos Repositórios via mixins ou herança.
- **presentation**: Blocs/Cubits, Pages e Widgets.

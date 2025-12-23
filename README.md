# Ecclesia Next

Ecclesia Next é um aplicativo SaaS White-Label para igrejas, focado em minimalismo, design moderno e alta performance.

## Stack Tecnológica

- **Framework**: Flutter (iOS & Android)
- **Backend (BaaS)**: Firebase (Auth, Firestore, Storage)
- **Gerência de Estado**: BLoC (Business Logic Component)
- **Injeção de Dependência**: GetIt
- **Arquitetura**: Clean Architecture (Domain, Data, Presentation)

## Estrutura do Projeto

O projeto segue estritamente a Clean Architecture para garantir escalabilidade e testabilidade.

```
lib/
├── core/                   # Utilitários globais, tratamento de erros, config
│   ├── di/                 # Injeção de dependência (Service Locator)
│   ├── error/              # Definições de falhas e exceções
│   └── theme/              # Temas e estilos globais
├── features/               # Funcionalidades do app (ex: auth, sermon, events)
│   ├── [feature_name]/
│   │   ├── domain/         # Regras de neǵocio (Entities, UseCases, Repositories Interfaces)
│   │   ├── data/           # Implementação de dados (Models, Datasources, Repositories Impl)
│   │   └── presentation/   # UI (Pages, Widgets, Blocs)
└── main.dart               # Ponto de entrada
```

## Setup do Ambiente

Como este projeto foi gerado manualmente, siga os passos abaixo para inicializar:

1.  **Instalar dependências**:
    ```bash
    flutter pub get
    ```

2.  **Configurar Firebase**:
    - Instale o `flutterfire_cli`.
    - Rode `flutterfire configure` para vincular ao projeto Firebase.

## Plano de Implementação (Roadmap)

### Fase 1: Fundação (Atual)
- [x] Estrutura de pastas Clean Arch.
- [x] Configuração de dependências (`pubspec.yaml`).
- [ ] Configuração do Firebase Core.
- [ ] Definição do Tema Minimalista (Light/Dark).

### Fase 2: Autenticação Multi-tenant
- [ ] Login/Cadastro com Email e Senha.
- [ ] Identificação da Igreja (Tenant ID).
- [ ] Tela de Splash com carregamento dinâmico da logo da igreja.

### Fase 3: Home & Feed
- [ ] Criação do Dashboard principal.
- [ ] Feed de notícias/avisos da igreja.

### Fase 4: Mídia & Conteúdo
- [ ] Player de áudio/vídeo para sermões.
- [ ] Integração com Firebase Storage.

### Fase 5: White-labeling Dinâmico
- [ ] Lógica para trocar cores e assets baseado na configuração da igreja.

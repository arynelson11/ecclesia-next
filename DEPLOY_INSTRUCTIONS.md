# 🚀 Instruções de Segredos (Vercel + GitHub Actions)

Para que o deploy funcione automaticamente, você precisa configurar os **Secrets** no seu repositório do GitHub.

## 1. Obter Vercel Token (`VERCEL_TOKEN`)
1. Acesse https://vercel.com/account/tokens
2. Crie um novo token chamado `GITHUB_ACTION`.
3. Copie o valor.

## 2. Obter `VERCEL_ORG_ID` e `VERCEL_PROJECT_ID`
1. No seu projeto na Vercel (Dashboard), vá em **Settings**.
2. Na aba **General**, role para baixo até a seção **Project ID**. Copie.
3. Logo abaixo (ou na URL da sua conta/team), copie o **Organization ID**.

## 3. Configurar Secrets no GitHub
1. Vá no seu repositório GitHub.
2. Clique em **Settings** > **Secrets and variables** > **Actions**.
3. Clique em **New repository secret**.
4. Adicione:

| Nome | Valor |
| :--- | :--- |
| `VERCEL_TOKEN` | Token do passo 1. |
| `VERCEL_ORG_ID` | Organization ID do passo 2. |
| `VERCEL_PROJECT_ID` | Project ID do passo 2. |

---

## Próximo Passo
Apenas faça o push!

```bash
git add .
git commit -m "Configura CI/CD Vercel"
git push origin main
```

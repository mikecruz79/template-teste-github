# 🛠️ Template de Repositório Profissional Automatizado

Este repositório contém o script **`git-rep.sh`**, um provisionador 100% automatizado para criar repositórios profissionais no GitHub em poucos minutos. O objetivo é oferecer um ponto de partida robusto, com o mínimo de fricção possível, já alinhado às boas práticas utilizadas em projetos reais — seja para estudos pessoais, MVPs ou trabalhos privados com clientes.

## ⚙️ O que o script entrega

Quando executado, o `git-rep.sh`:

1. **Coleta dados interativos** (nome do repo, visibilidade, stack, descrição).
2. **Gera estrutura base** (`src`, `tests`, `docs`, `scripts`, `.github`...).
3. **Cria README opinativo** com instruções de uso e badge do CI.
4. **Configura stack escolhida** (Node.js, Python, Rust, Go ou genérica).
5. **Adiciona CI/CD seguro** (workflow com scan de segredos, testes e validações).
6. **Configura proteções** adequadas para contas free/privadas.
7. **Cria repositório no GitHub** e realiza push inicial automaticamente.
8. **Habilita Dependabot** com ecosistema alinhado à stack escolhida.

O resultado é um repositório pronto para trabalhar de forma segura e profissional — inclusive quando o cliente exige controles mínimos (CI, proteções, templates de PR etc.).

## 🚀 Cenários de uso

- Prototipar rapidamente uma base profissional sem esquecer de segurança.
- Criar repositórios privados confiáveis para clientes.
- Padronizar o kick-off de projetos internos ou pessoais.
- Usar como template em agências/freelas que geram muitos projetos similares.

## 📦 Como executar localmente

```bash
chmod +x git-rep.sh
./git-rep.sh
```

O script guiará você com as perguntas necessárias. Assim que terminar, o repo já estará criado no GitHub, com push inicial, CI configurado e proteções aplicadas.

## ✅ Pré-requisitos

- `git` e `gh` instalados e autenticados (`gh auth login`).
- Acesso ao GitHub para criação de repositórios (mesmo em plano free).
- Docker instalado (usado no pipeline para trufflehog via filesystem scan).

## 🧩 Estrutura gerada (exemplo)

```
src/         → Código fonte inicial
tests/       → Área reservada para testes
docs/        → Documentação complementar
scripts/     → Utilidades e automações
.github/     → Workflows de CI/CD + Dependabot
```

## 🔐 Segurança e boas práticas incluídas

- `.gitignore` opinativo para evitar vazamento de credenciais
- TruffleHog rodando via Docker (filesystem scan)
- Template de PR com checklist de segurança
- Proteções locais e instruções para contas free
- Dependabot configurado semanalmente

## 🤝 Contribuindo

Se tiver ideias de stacks adicionais, novas regras de segurança ou qualquer melhoria, abra uma Issue ou PR. O objetivo é manter este template simples, direto e pronto para uso no dia a dia sem sofrimento.

---

**Feito para quem precisa iniciar rápido e com confiança — do pessoal ao corporativo.**

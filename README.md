# 🛠️ Template de Repositório Profissional Automatizado

<p align="left">
  <a href="https://github.com/mikecruz79/template-teste-github/actions/workflows/seguranca.yml">
    <img src="https://github.com/mikecruz79/template-teste-github/actions/workflows/seguranca.yml/badge.svg" alt="CI Status" />
  </a>
  <a href="https://github.com/mikecruz79/template-teste-github/security/dependabot">
    <img src="https://img.shields.io/badge/Dependabot-ativo-0e8a16?logo=dependabot" alt="Dependabot" />
  </a>
  <img src="https://img.shields.io/badge/Stack-Multi-blue" alt="Multi Stack" />
  <img src="https://img.shields.io/badge/Segurança-Pronta-ff5f5f" alt="Segurança" />
</p>

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
# Clone e entre no projeto base
git clone https://github.com/mikecruz79/template-teste-github.git
cd template-teste-github

# Garanta permissão de execução
chmod +x git-rep.sh
```

Em seguida rode o script:

```bash
./git-rep.sh
```

O script guiará você com as perguntas necessárias. Assim que terminar, o repo já estará criado no GitHub, com push inicial, CI configurado e proteções aplicadas.

> **Dica:** Como o `git-rep.sh` vive neste mesmo repositório (raiz do projeto), você pode modificar o script e versionar melhorias conforme suas necessidades.

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
- TruffleHog automatizado via GitHub Action oficial (`v3.94.0`)
- Template de PR com checklist de segurança detalhado
- Proteções locais (pre-commit hooks) e instruções de branches
- Dependabot configurado para `npm` e `github-actions`

## 🤝 Contribuindo

Se tiver ideias de stacks adicionais, novas regras de segurança ou qualquer melhoria, abra uma Issue ou PR. O objetivo é manter este template simples, direto e pronto para uso no dia a dia sem sofrimento.

---

**Feito para quem precisa iniciar rápido e com confiança — do pessoal ao corporativo.**

---

# 🇬🇧 Professional Repository Template (English Version)

This repository ships with the **`git-rep.sh`** script, an automated provisioner that creates production-ready GitHub repositories in minutes. The goal is to provide a minimal yet robust starting point aligned with industry best practices — perfect for side projects, MVPs, or private client engagements.

## ⚙️ What the script delivers

1. **Interactive prompts** for repo name, visibility, stack, description.
2. **Base structure** (`src`, `tests`, `docs`, `scripts`, `.github`, etc.).
3. **Opinionated README** with usage instructions and CI badge.
4. **Stack setup** for Node.js, Python, Rust, Go, or a minimal option.
5. **Secure CI/CD** (secret scanning, tests, validation steps).
6. **Branch protections / guardrails** tailored for free/private accounts.
7. **Automatic GitHub repo creation** with initial push.
8. **Dependabot enabled** with the correct ecosystem for the chosen stack.

## 🚀 Use cases

- Create professional-grade repos without missing security basics.
- Spin up trustworthy private repos for clients quickly.
- Standardize kick-offs for internal initiatives or personal projects.
- Adopt as an agency/freelancer template for repeatable work.

## 📦 How to run locally

```bash
# Clone and enter the base project
git clone https://github.com/mikecruz79/template-teste-github.git
cd template-teste-github

# Ensure execution permission
chmod +x git-rep.sh

# Run the provisioner
./git-rep.sh
```

The script walks you through all required answers. Once finished, the new repository is already on GitHub — CI is enabled, protections applied, and Dependabot configured.

> **Tip:** Because `git-rep.sh` lives in this repo, you can evolve it and push improvements that benefit every future project.

## ✅ Requirements

- `git` and `gh` installed + authenticated (`gh auth login`).
- Permission to create repositories on GitHub (works even on free plans).
- Docker installed (used for TruffleHog filesystem scanning in CI).

## 🧩 Generated structure (example)

```
src/         → Source code
tests/       → Automated tests
docs/        → Documentation
scripts/     → Utilities & automation
.github/     → CI/CD workflows + Dependabot
```

## 🔐 Security & best practices baked in

- Hardening `.gitignore` to avoid accidental secrets
- TruffleHog via Docker (filesystem scan)
- Pull request template with security checklist
- Local guardrails + instructions for free accounts
- Weekly Dependabot updates

## 🤝 Contributing

Ideas for new stacks, better protections, or workflow tweaks? Open an Issue or PR — the mission is to keep this template lean, straightforward, and battle-tested.

---

**Built for anyone who wants a confident start — from hobbyists to enterprise teams.**

## 🙏 Agradecimentos · Acknowledgements

<div align="center" style="line-height:1">
  <a href="https://www.kimi.com" target="_blank">
    <img alt="Chat" src="https://img.shields.io/badge/🤖%20Chat-Kimi%20K2.5-ff6b6b?color=1783ff&logoColor=white" />
  </a>
</div>

Este template foi desenvolvido com assistência de **[Kimi K2.5](https://kimi.com)**
da **[Moonshot AI](https://www.moonshot.cn)** — parceria de lapidação contínua
onde código e intenção se encontram.

This template was crafted with support from **[Kimi K2.5](https://kimi.com)**
by **[Moonshot AI](https://www.moonshot.cn)** — a continuous polishing partnership
where code and intent meet.

> _"O ruído de hoje é o sinal de debug de amanhã"_ / _“Today's noise becomes tomorrow's debug signal.”_

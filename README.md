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
- TruffleHog rodando via Docker (filesystem scan)
- Template de PR com checklist de segurança
- Proteções locais e instruções para contas free
- Dependabot configurado semanalmente

## 🤝 Contribuindo

Se tiver ideias de stacks adicionais, novas regras de segurança ou qualquer melhoria, abra uma Issue ou PR. O objetivo é manter este template simples, direto e pronto para uso no dia a dia sem sofrimento.

---

**Feito para quem precisa iniciar rápido e com confiança — do pessoal ao corporativo.**

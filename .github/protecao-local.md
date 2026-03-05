# 🛡️ Proteções Locais (Funcionam no Plano Free)

## Pre-commit Hooks (Recomendado)
Instale hooks locais para bloquear commits inseguros:

```bash
# Instala pre-commit
pip install pre-commit  # ou: npm install -g pre-commit

# Cria arquivo .pre-commit-config.yaml
cat > .pre-commit-config.yaml << 'HOOK'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: detect-private-key
      - id: check-added-large-files
      - id: check-merge-conflict

  - repo: https://github.com/trufflesecurity/trufflehog
    rev: v3.59.0
    hooks:
      - id: trufflehog
        args: ["--only-verified"]
HOOK

pre-commit install
pre-commit run --all-files

Checklist Manual (Free Tier)
[ ] Sempre rode git status antes de commitar
[ ] Verifique se .env está em vermelho (untracked), não verde (staged)
[ ] Nunca commitar arquivos >100MB
[ ] Use branches: git checkout -b feature/nome
[ ] Abra PR mesmo sendo só você (força revisão)
Workaround para Branch Protection (Free)
Como repo privado free não tem branch protection nativo,
configure no meu ~/.bashrc:
alias git-push-safe='git diff --cached && read -p "Revisado? (s/n): " ok && [ "$ok" = "s" ] && git push'

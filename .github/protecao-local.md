# 🛡️ Proteções locais

Mesmo trabalhando com automações e CI, a TRAMA adota proteções locais para reduzir risco antes do código sair da máquina.

## Pre-commit hooks

Instale hooks locais para bloquear commits inseguros e erros evitáveis.

```bash
pip install pre-commit

cat > .pre-commit-config.yaml << 'HOOK'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: detect-private-key
      - id: check-added-large-files
      - id: check-merge-conflict
      - id: end-of-file-fixer
      - id: trailing-whitespace

  - repo: https://github.com/trufflesecurity/trufflehog
    rev: v3.90.5
    hooks:
      - id: trufflehog
        args: ["--results=verified,unknown", "--fail"]
HOOK

pre-commit install
pre-commit run --all-files
```

## Checklist manual antes de commitar

* [ ] Rodei `git status`
* [ ] `.env` e arquivos sensíveis não estão staged
* [ ] Não há arquivos de segredo (`*.pem`, `*.key`, `secrets/`, `.env*`) no commit
* [ ] Não há arquivos grandes sem necessidade
* [ ] A mudança ficou em branch própria
* [ ] Revisei o diff antes de subir

## Fluxo recomendado

* criar branch por mudança
* abrir PR mesmo trabalhando sozinho
* revisar o diff com calma antes de mergear

## Observação importante

Este repositório pode não contar com branch protection nativa no plano atual.
Por isso, proteções locais, PR e revisão manual não são opcionais.

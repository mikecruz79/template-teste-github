# template-teste-github

## 🎯 O que é
um template completo de teste para github, pode ser usado em work's reais.

## 🛠️ Tecnologias
- Python

## 🔐 Segurança
- Código versionado com histórico completo
- Scan automático de segredos em todo commit
- Dependências verificadas contra vulnerabilidades
- Branch protection em branches principais

## 📁 Estrutura
```
src/         → Código fonte
tests/       → Testes automatizados
docs/        → Documentação
scripts/     → Automações e utilitários
.github/     → Workflows de CI/CD
```

## 🚀 Como rodar local

```bash
# 1. Clone o repositório
git clone https://github.com/mikecruz79/template-teste-github.git
cd template-teste-github

# 2. Instale dependências
pip install -r requirements.txt

# 3. Rode em desenvolvimento
python src/main.py
```

## 📋 Status do CI
![Seguranca](https://github.com/mikecruz79/template-teste-github/actions/workflows/seguranca.yml/badge.svg)

---

**⚠️ Atenção:** Nunca commite arquivos `.env`, `secrets/` ou chaves privadas. O `.gitignore` já protege, mas verifique sempre com `git status` antes de commitar.

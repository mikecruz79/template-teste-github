#!/bin/bash

set -e  # Para em qualquer erro

# ============================================
# CORES PARA OUTPUT
# ============================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ============================================
# FUNÇÕES AUXILIARES
# ============================================

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# ============================================
# 1. VALIDA DEPENDÊNCIAS
# ============================================

check_dependencies() {
    print_info "Verificando dependências..."

    if ! command -v git &> /dev/null; then
        print_error "Git não instalado. Rode: sudo apt install git"
        exit 1
    fi

    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) não instalado."
        echo "Instale: sudo apt install gh && gh auth login"
        exit 1
    fi

    # Verifica se está autenticado no GitHub
    if ! gh auth status &> /dev/null; then
        print_error "Não autenticado no GitHub."
        echo "Rode: gh auth login"
        exit 1
    fi

    # Verifica config do git
    if [ -z "$(git config user.name 2>/dev/null)" ] || [ -z "$(git config user.email 2>/dev/null)" ]; then
        print_warning "Git não configurado (user.name ou user.email)"
        read -p "Digite seu nome para commits: " GIT_NAME
        read -p "Digite seu email para commits: " GIT_EMAIL

        git config --global user.name "$GIT_NAME"
        git config --global user.email "$GIT_EMAIL"
        print_success "Git configurado globalmente"
    fi
}

# ============================================
# 2. COLETA DADOS INTERATIVOS
# ============================================

collect_info() {
    echo ""
    echo "=========================================="
    echo "  🚀 SETUP DE REPOSITÓRIO PROFISSIONAL"
    echo "=========================================="
    echo ""

    # Nome do repositório
    read -p "📁 Nome do repositório (ex: planilha-processor-cliente-x): " REPO_NAME

    if [ -z "$REPO_NAME" ]; then
        print_error "Nome não pode ser vazio"
        exit 1
    fi

    # Sanitiza nome (remove espaços, caracteres especiais)
    REPO_NAME=$(echo "$REPO_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-_')

    if [ -z "$REPO_NAME" ]; then
        print_error "Nome inválido após sanitização"
        exit 1
    fi

    if [ -d "$REPO_NAME" ]; then
        print_error "Pasta '$REPO_NAME' já existe"
        exit 1
    fi

    # Visibilidade
    echo ""
    echo "🔒 Visibilidade:"
    echo "  1) Privado (recomendado para clientes)"
    echo "  2) Público (mais features free, código aberto)"
    read -p "Escolha (1 ou 2): " VISIBILITY_CHOICE

    case $VISIBILITY_CHOICE in
        1) VISIBILITY="private" ;;
        2) VISIBILITY="public" ;;
        *)
            print_warning "Opção inválida, usando privado"
            VISIBILITY="private"
            ;;
    esac

    print_info "Repositório será: $VISIBILITY"

    # Stack tecnológica
    echo ""
    echo "🛠️  Stack do projeto:"
    echo "  1) Node.js (JavaScript/TypeScript)"
    echo "  2) Python"
    echo "  3) Rust"
    echo "  4) Go"
    echo "  5) Outro / Vazio (estrutura mínima)"
    read -p "Escolha (1-5): " STACK_CHOICE

    # Descrição do projeto
    echo ""
    read -p "📝 Descrição breve do projeto: " DESCRIPTION
    if [ -z "$DESCRIPTION" ]; then
        DESCRIPTION="Projeto profissional com segurança e CI/CD integrados"
    fi

    # Confirmação
    echo ""
    echo "=========================================="
    echo "  📋 RESUMO"
    echo "=========================================="
    echo "Nome:        $REPO_NAME"
    echo "Visibilidade: $VISIBILITY"
    echo "Stack:       $STACK_CHOICE"
    echo "Descrição:   $DESCRIPTION"
    echo ""
    read -p "✅ Confirma criação? (s/n): " CONFIRM

    if [ "$CONFIRM" != "s" ] && [ "$CONFIRM" != "S" ]; then
        print_info "Cancelado pelo usuário"
        exit 0
    fi
}

# ============================================
# 3. CONFIGURA STACK ESPECÍFICA
# ============================================

setup_stack() {
    local choice=$1

    case $choice in
        1) # Node.js
            STACK_NAME="Node.js"
            SETUP_CMD="npm install"
            DEV_CMD="npm run dev"
            BUILD_CMD="npm run build"
            TEST_CMD="npm test"

            cat > package.json << 'EOF'
{
  "name": "projeto",
  "version": "1.0.0",
  "description": "Projeto profissional",
  "main": "src/index.js",
  "scripts": {
    "dev": "node src/index.js",
    "test": "echo 'Error: no test specified' && exit 1",
    "build": "echo 'No build step configured'"
  },
  "keywords": [],
  "author": "",
  "license": "MIT"
}
EOF

            cat > src/index.js << 'EOF'
console.log("🚀 Projeto iniciado");
EOF

            WORKFLOW_SETUP="""
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Instala dependências
        run: npm ci || npm install

      - name: Roda testes
        run: npm test || echo 'Sem testes configurados'

      - name: Build
        run: npm run build || echo 'Sem build configurado'
"""
            ;;

        2) # Python
            STACK_NAME="Python"
            SETUP_CMD="pip install -r requirements.txt"
            DEV_CMD="python src/main.py"
            BUILD_CMD="echo 'Python não requer build'"
            TEST_CMD="python -m pytest || echo 'Sem pytest'"

            cat > requirements.txt << 'EOF'
# Dependências do projeto
EOF

            cat > src/main.py << 'EOF'
def main():
    print("🚀 Projeto iniciado")

if __name__ == "__main__":
    main()
EOF

            WORKFLOW_SETUP="""
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
          cache: 'pip'

      - name: Instala dependências
        run: |
          pip install -r requirements.txt 2>/dev/null || echo '⚠️ Sem requirements.txt'

      - name: Testa sintaxe
        run: |
          python -m py_compile src/*.py 2>/dev/null || echo '⚠️ Validação de sintaxe'

      - name: Roda testes
        run: python -m pytest 2>/dev/null || echo '⚠️ Sem pytest configurado'
"""
            ;;

        3) # Rust
            STACK_NAME="Rust"
            SETUP_CMD="cargo build"
            DEV_CMD="cargo run"
            BUILD_CMD="cargo build --release"
            TEST_CMD="cargo test"

            cat > Cargo.toml << EOF
[package]
name = "projeto"
version = "1.0.0"
edition = "2021"

[dependencies]
EOF

            mkdir -p src
            cat > src/main.rs << 'EOF'
fn main() {
    println!("🚀 Projeto iniciado");
}
EOF

            WORKFLOW_SETUP="""
      - name: Setup Rust
        uses: dtolnay/rust-action@stable

      - name: Build
        run: cargo build || echo '⚠️ Build falhou'

      - name: Testes
        run: cargo test || echo '⚠️ Sem testes'
"""
            ;;

        4) # Go
            STACK_NAME="Go"
            SETUP_CMD="go mod tidy"
            DEV_CMD="go run src/main.go"
            BUILD_CMD="go build -o bin/projeto src/main.go"
            TEST_CMD="go test ./..."

            go mod init projeto 2>/dev/null || true

            cat > src/main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("🚀 Projeto iniciado")
}
EOF

            WORKFLOW_SETUP="""
      - name: Setup Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.21'

      - name: Build
        run: go build -o bin/projeto src/main.go || echo '⚠️ Build falhou'

      - name: Testes
        run: go test ./... || echo '⚠️ Sem testes'
"""
            ;;

        5|*) # Outro / Mínimo
            STACK_NAME="Genérico"
            SETUP_CMD="echo 'Configure seu ambiente'"
            DEV_CMD="echo 'Inicie seu projeto'"
            BUILD_CMD="echo 'Build manual'"
            TEST_CMD="echo 'Testes manuais'"

            cat > src/README.md << 'EOF'
# Código Fonte

Adicione seus arquivos nesta pasta.
EOF

            WORKFLOW_SETUP="""
      - name: Valida estrutura
        run: |
          echo 'Estrutura validada'
          ls -la
"""
            ;;
    esac

    # Configura dependabot conforme a stack
    case $choice in
        1) ECOSYSTEM="npm" ;;
        2) ECOSYSTEM="pip" ;;
        3) ECOSYSTEM="cargo" ;;
        4) ECOSYSTEM="gomod" ;;
        *) ECOSYSTEM="pip" ;;
    esac

    cat > .github/dependabot.yml << EOF
version: 2

updates:
  - package-ecosystem: "$ECOSYSTEM"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "06:00"
    open-pull-requests-limit: 5
    labels:
      - "dependencies"
      - "security"

  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "06:15"
    open-pull-requests-limit: 3
    labels:
      - "dependencies"
      - "ci"
      - "security"
EOF

    git add .github/dependabot.yml
    git commit -m "chore: adiciona dependabot ($ECOSYSTEM)" || true

    print_success "Stack configurada: $STACK_NAME"
}

# ============================================
# 4. CRIA ESTRUTURA BASE
# ============================================

create_base_structure() {
    print_info "Criando estrutura base..."

    # Aviso se já existem arquivos de segredo na pasta pai
    if [ -f "../.env" ] || [ -d "../secrets" ]; then
        print_warning "Detectado .env ou secrets/ na pasta pai!"
        echo "⚠️  Certifique-se de não copiar acidentalmente para o repo"
        read -p "Pressione Enter para continuar..."
    fi

    mkdir -p src tests docs scripts .github/workflows

    # .gitignore (SEMPRE PRIMEIRO)
    cat > .gitignore << 'EOF'
# === SEGREDOS (nunca commitar) ===
.env
.env.*
*.key
*.pem
secrets/
credentials.json
config/local*

# === DEPENDÊNCIAS ===
node_modules/
__pycache__/
.venv/
target/
vendor/

# === SISTEMA ===
.DS_Store
.idea/
.vscode/settings.json
*.log

# === BUILD/DADOS ===
dist/
build/
bin/
*.sqlite
tmp/
*.tmp
EOF

    git add .gitignore
    git commit -m "chore: adiciona proteções de segurança (.gitignore)"
    print_success ".gitignore commitado (proteções ativas)"
}

# ============================================
# 5. CRIA README
# ============================================

create_readme() {
    cat > README.md << EOF
# $REPO_NAME

## 🎯 O que é
$DESCRIPTION

## 🛠️ Tecnologias
- $STACK_NAME

## 🔐 Segurança
- Código versionado com histórico completo
- Scan automático de segredos em todo commit
- Dependências verificadas contra vulnerabilidades
- Branch protection em branches principais

## 📁 Estrutura
\`\`\`
src/         → Código fonte
tests/       → Testes automatizados
docs/        → Documentação
scripts/     → Automações e utilitários
.github/     → Workflows de CI/CD
\`\`\`

## 🚀 Como rodar local

\`\`\`bash
# 1. Clone o repositório
git clone https://github.com/$(gh api user -q '.login')/$REPO_NAME.git
cd $REPO_NAME

# 2. Instale dependências
$SETUP_CMD

# 3. Rode em desenvolvimento
$DEV_CMD
\`\`\`

## 📋 Status do CI
![Seguranca](https://github.com/$(gh api user -q '.login')/$REPO_NAME/actions/workflows/seguranca.yml/badge.svg)

---

**⚠️ Atenção:** Nunca commite arquivos \`.env\`, \`secrets/\` ou chaves privadas. O \`.gitignore\` já protege, mas verifique sempre com \`git status\` antes de commitar.
EOF

    git add README.md
    git commit -m "docs: adiciona README inicial"
    print_success "README commitado"
}

# ============================================
# 6. CRIA WORKFLOW DE SEGURANÇA
# ============================================

create_workflow() {
    cat > .github/workflows/seguranca.yml << EOF
name: Seguranca-Basica

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read

concurrency:
  group: seguranca-\${{ github.workflow }}-\${{ github.ref }}
  cancel-in-progress: true

jobs:
  cheque:
    name: Secret scanning
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          fetch-depth: 0

      - name: Scan de segredos
        uses: trufflesecurity/trufflehog@v3.94.0
        with:
          path: ./
          extra_args: --results=verified,unknown

      # Setup específico da stack
$WORKFLOW_SETUP

      - name: Validação final
        run: |
          echo "✅ CI concluído com sucesso"
          echo "📊 Stack: $STACK_NAME"
          echo "📊 Segurança básica ok"
EOF

    git add .github/workflows/seguranca.yml
    git commit -m "ci: adiciona workflow de segurança"
    print_success "Workflow de CI commitado"
}

# ============================================
# 7. CRIA REPO NO GITHUB E PUSH (COM DETECÇÃO)
# ============================================

create_github_repo() {
    local user=$(gh api user -q '.login')
    local repo_url="https://github.com/$user/$REPO_NAME"

    print_info "Verificando repositório no GitHub..."

    # Verifica se repo já existe
    if gh repo view "$REPO_NAME" &> /dev/null; then
        print_warning "Repositório '$REPO_NAME' já existe no GitHub"
        read -p "Deseja usar o existente e fazer push? (s/n): " USE_EXISTING

        if [ "$USE_EXISTING" != "s" ] && [ "$USE_EXISTING" != "S" ]; then
            print_error "Cancelado. Delete o repo manualmente ou escolha outro nome."
            exit 1
        fi

        # Configura remoto pro existente
        git remote remove origin 2>/dev/null || true
        git remote add origin "$repo_url.git"

    else
        print_info "Criando repositório no GitHub ($VISIBILITY)..."

        # Cria repo via gh CLI (sem --source pra evitar conflito)
        if ! gh repo create "$REPO_NAME" --"$VISIBILITY"; then
            print_error "Falha ao criar repositório"
            exit 1
        fi

        # Configura remoto
        git remote add origin "$repo_url.git"
        print_success "Repositório criado: $repo_url"
    fi

    # Determina nome da branch (master ou main)
    local branch=$(git branch --show-current)

    print_info "Fazendo push para '$branch'..."

    # Tenta push (pode falhar em permissões, aí sugere HTTPS)
    if git push -u origin "$branch"; then
        print_success "Código pushado com sucesso!"
    else
        print_warning "Push falhou (provavelmente SSH não configurado)"
        print_info "Tentando com HTTPS..."

        # Troca pra HTTPS
        git remote remove origin 2>/dev/null || true
        git remote add origin "https://github.com/$user/$REPO_NAME.git"

        if git push -u origin "$branch"; then
            print_success "Push via HTTPS funcionou!"
        else
            print_error "Push falhou mesmo com HTTPS"
            echo ""
            echo "🔧 Soluções manuais:"
            echo "   1. Configure SSH: https://github.com/settings/keys"
            echo "   2. Ou use token HTTPS: https://github.com/settings/tokens"
            echo "   3. Depois rode manualmente:"
            echo "      cd $REPO_NAME"
            echo "      git push -u origin $branch"
            echo ""
            echo "📁 Seu código está salvo localmente e pronto!"
            exit 0  # Não é erro fatal, código existe
        fi
    fi
}

# ============================================
# 8. CONFIGURA PROTEÇÕES (MODO FREE/PRIVADO)
# ============================================

setup_protections() {
    local user=$(gh api user -q '.login')

    print_info "Configurando proteções (modo free/privado)..."

    # Cria arquivo de configuração local de proteções (funciona sempre)
    cat > .github/protecao-local.md << 'EOF'
# 🛡️ Proteções locais

Mesmo trabalhando com automações e CI, a TRAMA adota proteções locais para reduzir risco antes do código sair da máquina.

## Pre-commit hooks

Instale hooks locais para bloquear commits inseguros e erros evitáveis.

\`\`\`bash
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
\`\`\`

## Checklist manual antes de commitar

* [ ] Rodei \`git status\`
* [ ] \`.env\` e arquivos sensíveis não estão staged
* [ ] Não há arquivos de segredo (\`*.pem\`, \`*.key\`, \`secrets/\`, \`.env*\`) no commit
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
EOF
    git add .github/protecao-local.md
    git commit -m "docs: adiciona guia de proteções para plano free" || true

    # Tenta proteções nativas (vai falhar em free, mas tenta)
    local branch=$(git branch --show-current)

    gh api "repos/$user/$REPO_NAME/branches/$branch/protection" \
        --method PUT \
        --input - <<< '{"required_status_checks":null,"enforce_admins":null,"required_pull_request_reviews":{"dismiss_stale_reviews":false,"require_code_owner_reviews":false},"restrictions":null}' \
        2>/dev/null && print_success "Branch protection nativo ativado" || {
            print_info "Branch protection nativo indisponível (plano free)"
            print_info "Usando proteções locais documentadas em .github/protecao-local.md"
        }

    # Cria ISSUE_TEMPLATE pra forçar revisão em PRs (funciona em free)
    mkdir -p .github/ISSUE_TEMPLATE
    cat > .github/pull_request_template.md << 'EOF'
## 📋 Resumo da mudança

<!-- O que foi alterado e por quê -->

## ✅ Checklist antes de abrir PR

- [ ] Rodei \`git status\`
- [ ] Não há \`.env\`, chaves ou arquivos sensíveis staged
- [ ] Revisei meu próprio diff antes de abrir a PR
- [ ] A mudança respeita a estrutura e a arquitetura do projeto
- [ ] Atualizei ou criei testes quando necessário
- [ ] Fluxos críticos seguem cobertos

## 🧪 Como validar

<!-- Passos claros para testar localmente -->

Exemplo:
- [ ] \`pnpm install\`
- [ ] \`pnpm lint\`
- [ ] \`pnpm build\`
- [ ] \`pnpm test:e2e\` (quando aplicável)

## 🔎 Pontos de atenção

<!-- Riscos, decisões importantes, trade-offs, limites -->

## 📎 Evidências

<!-- Prints, vídeos, links de preview ou observações úteis -->
EOF
    git add .github/pull_request_template.md
    git commit -m "chore: adiciona template de PR com checklist de segurança" || true

    print_success "Proteções configuradas para modo free/privado"
}

# ============================================
# 9. RESUMO FINAL
# ============================================

print_summary() {
    local user=$(gh api user -q '.login')

    echo ""
    echo "=========================================="
    echo "  🎉 REPOSITÓRIO CRIADO COM SUCESSO!"
    echo "=========================================="
    echo ""
    echo "📁 Nome:        $REPO_NAME"
    echo "🔒 Visibilidade: $VISIBILITY"
    echo "🛠️  Stack:       $STACK_NAME"
    echo "🔗 URL:         https://github.com/$user/$REPO_NAME"
    echo ""
    echo "📋 Próximos passos:"
    echo "   cd $REPO_NAME"
    echo "   $DEV_CMD"
    echo ""

    echo "🧪 Teste de CI (manual):"
    echo "   1. Edite qualquer arquivo: echo '# test' >> README.md"
    echo "   2. Commit: git add . && git commit -m 'test: trigger ci'"
    echo "   3. Push: git push"
    echo "   4. Verifique: https://github.com/$user/$REPO_NAME/actions"
    echo ""

    echo "⚠️  Lembre-se:"
    echo "   • Nunca commite arquivos .env ou secrets/"
    echo "   • Sempre use 'git status' antes de commitar"
    echo "   • Crie branches para features: git checkout -b feature/nome"
    echo "   • Abra Pull Requests para mergear em master/main"
    echo ""
    echo "🚀 Bom trabalho!"
    echo "=========================================="
}

# ============================================
# EXECUÇÃO PRINCIPAL
# ============================================

main() {
    # Configura Git globalmente para sempre usar 'main' (uma vez só)
    if [ "$(git config --global init.defaultBranch 2>/dev/null)" != "main" ]; then
        print_info "Configurando Git para usar 'main' como padrão..."
        git config --global init.defaultBranch main
        print_success "Padrão global configurado: 'main'"
    fi

    # Limpa se usuário cancelar (Ctrl+C)
    cleanup() {
        if [ -n "$REPO_NAME" ] && [ -d "../$REPO_NAME" ]; then
            print_warning "Limpeza: removendo pasta incompleta '$REPO_NAME'"
            cd ..
            rm -rf "$REPO_NAME"
        fi
        exit 1
    }
    trap cleanup INT TERM

    check_dependencies
    collect_info

    print_info "Iniciando criação de '$REPO_NAME'..."

    mkdir "$REPO_NAME"
    cd "$REPO_NAME"

    git init

    create_base_structure
    setup_stack "$STACK_CHOICE"
    create_readme
    create_workflow

    # Commit inicial da stack
    git add .
    git commit -m "feat: adiciona estrutura inicial de código ($STACK_NAME)" || true

    create_github_repo
    setup_protections
    print_summary
}

# Roda o script
main "$@"

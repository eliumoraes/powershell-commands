# Script para inicializar o repositório Git do PowerShell Commands Collection
# Execute este script para configurar o repositório com todas as branches e configurações

param(
    [string]$RepositoryName = "powershell-commands",
    [string]$GitHubUsername = "",
    [switch]$Help
)

if ($Help) {
    Write-Host "NOME" -ForegroundColor Cyan
    Write-Host "    init-repo.ps1"
    Write-Host ""
    Write-Host "SINOPSIS" -ForegroundColor Cyan
    Write-Host "    Inicializa o repositório Git com todas as configurações necessárias"
    Write-Host ""
    Write-Host "DESCRIÇÃO" -ForegroundColor Cyan
    Write-Host "    Este script configura o repositório Git com:"
    Write-Host "    - Inicialização do Git"
    Write-Host "    - Criação das branches principais (main, develop)"
    Write-Host "    - Configuração do remote do GitHub"
    Write-Host "    - Primeiro commit com todos os arquivos"
    Write-Host ""
    Write-Host "PARÂMETROS" -ForegroundColor Cyan
    Write-Host "    -RepositoryName <string>"
    Write-Host "        Nome do repositório (padrão: powershell-commands)"
    Write-Host ""
    Write-Host "    -GitHubUsername <string>"
    Write-Host "        Seu nome de usuário do GitHub"
    Write-Host ""
    Write-Host "    -Help"
    Write-Host "        Exibe esta mensagem de ajuda"
    Write-Host ""
    Write-Host "EXEMPLOS" -ForegroundColor Cyan
    Write-Host "    .\init-repo.ps1"
    Write-Host "        Inicializa com configurações padrão"
    Write-Host ""
    Write-Host "    .\init-repo.ps1 -RepositoryName 'meus-comandos' -GitHubUsername 'meu-usuario'"
    Write-Host "        Inicializa com nome personalizado e usuário do GitHub"
    return
}

Write-Host "🚀 Inicializando repositório Git para PowerShell Commands Collection..." -ForegroundColor Green
Write-Host ""

# Verificar se o Git está instalado
try {
    $gitVersion = git --version
    Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Error "❌ Git não encontrado. Instale o Git primeiro."
    exit 1
}

# Verificar se estamos em um repositório Git
if (Test-Path ".git") {
    Write-Host "⚠️  Repositório Git já existe. Continuando..." -ForegroundColor Yellow
} else {
    Write-Host "📁 Inicializando repositório Git..." -ForegroundColor Cyan
    git init
}

# Configurar usuário do Git se não estiver configurado
$gitUser = git config --global user.name
$gitEmail = git config --global user.email

if (-not $gitUser -or -not $gitEmail) {
    Write-Host "🔧 Configurando usuário Git..." -ForegroundColor Cyan
    
    if (-not $gitUser) {
        $gitUser = Read-Host "Digite seu nome para o Git"
        git config --global user.name $gitUser
    }
    
    if (-not $gitEmail) {
        $gitEmail = Read-Host "Digite seu email para o Git"
        git config --global user.email $gitEmail
    }
}

# Adicionar todos os arquivos
Write-Host "📦 Adicionando arquivos ao repositório..." -ForegroundColor Cyan
git add .

# Fazer o primeiro commit
Write-Host "💾 Criando primeiro commit..." -ForegroundColor Cyan
git commit -m "feat: initial commit - PowerShell Commands Collection v1.0.0

- Adiciona comandos Git para diff e stash
- Adiciona comandos de sistema para análise de projetos
- Implementa menu compacto com interface elegante
- Inclui documentação completa e exemplos
- Configura estrutura de versionamento e branches"

# Criar branch develop
Write-Host "🌿 Criando branch develop..." -ForegroundColor Cyan
git checkout -b develop

# Voltar para main
git checkout main

# Configurar remote do GitHub se fornecido
if ($GitHubUsername) {
    $remoteUrl = "https://github.com/$GitHubUsername/$RepositoryName.git"
    Write-Host "🔗 Configurando remote do GitHub: $remoteUrl" -ForegroundColor Cyan
    git remote add origin $remoteUrl
    
    Write-Host ""
    Write-Host "📋 Próximos passos:" -ForegroundColor Green
    Write-Host "1. Crie o repositório no GitHub: https://github.com/new"
    Write-Host "2. Nome do repositório: $RepositoryName"
    Write-Host "3. NÃO inicialize com README (já temos um)"
    Write-Host "4. Execute: git push -u origin main"
    Write-Host "5. Execute: git push -u origin develop"
} else {
    Write-Host ""
    Write-Host "📋 Para conectar ao GitHub:" -ForegroundColor Green
    Write-Host "1. Crie o repositório no GitHub"
    Write-Host "2. Execute: git remote add origin https://github.com/SEU-USUARIO/$RepositoryName.git"
    Write-Host "3. Execute: git push -u origin main"
    Write-Host "4. Execute: git push -u origin develop"
}

Write-Host ""
Write-Host "✅ Repositório inicializado com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Estrutura criada:" -ForegroundColor Cyan
Write-Host "   ├── main (branch principal)"
Write-Host "   ├── develop (branch de desenvolvimento)"
Write-Host "   ├── Microsoft.PowerShell_profile.ps1"
Write-Host "   ├── README.md"
Write-Host "   ├── CHANGELOG.md"
Write-Host "   ├── LICENSE"
Write-Host "   ├── .gitignore"
Write-Host "   └── docs/"
Write-Host "       ├── commands/"
Write-Host "       └── examples/"
Write-Host ""
Write-Host "🎯 Estratégia de branch configurada:" -ForegroundColor Cyan
Write-Host "   - main: código estável"
Write-Host "   - develop: desenvolvimento"
Write-Host "   - feature/*: novas funcionalidades"
Write-Host "   - hotfix/*: correções urgentes"
Write-Host "   - release/*: preparação para releases" 
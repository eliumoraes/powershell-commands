# 📖 Exemplos de Uso

Esta seção contém exemplos práticos de como usar os comandos do PowerShell Commands Collection.

## 🎯 Cenários Comuns

### 🔄 Trabalhando com Git

#### 1. Revisando Alterações Antes do Commit

```powershell
# Ver todas as alterações não preparadas
gitdiff-working

# Ver apenas alterações preparadas
gitdiff-staged

# Ignorar arquivos de log e temporários
gitdiff-working -ignore "*.log, *.tmp, temp/*"
```

#### 2. Comparando Branches

```powershell
# Comparar branch atual com master
gitdiff-branches

# Comparar duas branches específicas
gitdiff-branches -target develop -source feature/nova-funcionalidade

# Ignorar arquivos de documentação na comparação
gitdiff-branches -ignore "*.md, README*, docs/*"
```

#### 3. Gerenciando Stashes

```powershell
# Salvar trabalho atual em stashes separados
gitstash-triple -name "refatorando-autenticacao"

# Ver conteúdo de um stash específico
gitstash-show -stash "stash@{1}"

# Ver stash atual
gitstash-show
```

### 🔧 Análise de Projetos

#### 1. Explorando Estrutura de Projeto

```powershell
# Ver estrutura do diretório atual
tree-show

# Gerar dump completo do projeto
project-dump

# Dump excluindo arquivos binários
project-dump -ExcludeBinary

# Dump de projeto específico
project-dump -Path "C:\MeusProjetos\WebApp"
```

#### 2. Analisando Conteúdo de Arquivos

```powershell
# Listar arquivos e conteúdo
ListFilesWithContent
```

### 🛠️ Manutenção do Sistema

#### 1. Recarregando Configurações

```powershell
# Recarregar profile com feedback
refreshProfile

# Recarregar silenciosamente
refreshProfile -Silent
```

## 📋 Fluxos de Trabalho Completos

### 🔄 Fluxo de Desenvolvimento Típico

```powershell
# 1. Verificar alterações atuais
gitdiff-working

# 2. Preparar arquivos para commit
git add .

# 3. Verificar o que será commitado
gitdiff-staged

# 4. Se precisar salvar trabalho temporariamente
gitstash-triple -name "wip-autenticacao"

# 5. Fazer commit
git commit -m "feat: implementa autenticação"

# 6. Comparar com branch principal
gitdiff-branches -target main
```

### 🔍 Análise de Projeto Completa

```powershell
# 1. Ver estrutura geral
tree-show

# 2. Gerar documentação completa
project-dump -ExcludeBinary -MaxSizeKB 2048

# 3. Analisar diferenças com branch principal
gitdiff-branches -ignore "*.log, *.tmp, node_modules/*"
```

### 🚀 Preparação para Release

```powershell
# 1. Verificar todas as alterações
gitdiff-working
gitdiff-staged

# 2. Comparar com branch de produção
gitdiff-branches -target production

# 3. Salvar estado atual
gitstash-triple -name "pre-release-backup"

# 4. Gerar documentação do projeto
project-dump -Path "C:\Projeto" -ExcludeBinary
```

## 🎨 Dicas e Truques

### 📝 Personalizando Comandos

```powershell
# Criar alias personalizado
Set-Alias -Name gdw -Value gitdiff-working
Set-Alias -Name gds -Value gitdiff-staged
Set-Alias -Name gdb -Value gitdiff-branches
Set-Alias -Name gss -Value gitstash-show
Set-Alias -Name gst -Value gitstash-triple
Set-Alias -Name rp -Value refreshProfile
Set-Alias -Name ts -Value tree-show
Set-Alias -Name pd -Value project-dump
```

### 🔧 Configurações Avançadas

```powershell
# Configurar diretórios padrão para ignorar
$env:PROJECT_IGNORE_DIRS = "bin,obj,Debug,node_modules,.git"

# Configurar tamanho máximo de arquivo
$env:PROJECT_MAX_SIZE_KB = 1024

# Usar configurações personalizadas
project-dump -IgnoreDirs $env:PROJECT_IGNORE_DIRS.Split(',') -MaxSizeKB $env:PROJECT_MAX_SIZE_KB
```

### 📊 Monitoramento de Performance

```powershell
# Medir tempo de execução
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
project-dump
$stopwatch.Stop()
Write-Host "Tempo de execução: $($stopwatch.Elapsed.TotalSeconds) segundos"
```

## 🚨 Solução de Problemas

### ❌ Erros Comuns

#### 1. Comando não encontrado
```powershell
# Recarregar profile
refreshProfile

# Verificar se o comando existe
Get-Command gitdiff-working -ErrorAction SilentlyContinue
```

#### 2. Arquivo temporário não encontrado
```powershell
# Verificar diretório temporário
Write-Host "Diretório temporário: $env:TEMP"

# Listar arquivos temporários recentes
Get-ChildItem $env:TEMP | Where-Object { $_.Name -like "*git_diff*" -or $_.Name -like "*project_dump*" } | Sort-Object LastWriteTime -Descending | Select-Object -First 5
```

#### 3. Erro de permissão
```powershell
# Executar como administrador se necessário
Start-Process powershell -Verb RunAs
```

### 🔍 Debug

```powershell
# Habilitar debug detalhado
$VerbosePreference = "Continue"
gitdiff-working -Verbose

# Ver variáveis de ambiente
Get-ChildItem Env: | Where-Object { $_.Name -like "*TEMP*" -or $_.Name -like "*PROJECT*" }
```

## 📚 Recursos Adicionais

- [Documentação dos Comandos](../commands/README.md)
- [README Principal](../../README.md)
- [Changelog](../../CHANGELOG.md)

---

**Dica**: Use `-help` em qualquer comando para ver a documentação completa e exemplos específicos. 
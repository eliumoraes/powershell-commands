# 📚 Documentação dos Comandos

Esta seção contém documentação detalhada para todos os comandos disponíveis no PowerShell Commands Collection.

## 🎯 Índice

### Git Commands
- [gitdiff-working](#gitdiff-working)
- [gitdiff-staged](#gitdiff-staged)
- [gitdiff-branches](#gitdiff-branches)
- [gitstash-show](#gitstash-show)
- [gitstash-triple](#gitstash-triple)

### System Commands
- [refreshProfile](#refreshprofile)
- [tree-show](#tree-show)
- [project-dump](#project-dump)
- [ListFilesWithContent](#listfileswithcontent)

---

## Git Commands

### gitdiff-working

**Descrição**: Gera um diff de todas as alterações não preparadas (non-staged) e o exibe em um arquivo de texto temporário.

**Sintaxe**:
```powershell
gitdiff-working [-ignore <string>] [-limitLines <int>] [-help]
```

**Parâmetros**:
- `-ignore <string>`: Lista de arquivos ou padrões para ignorar (separados por vírgula)
- `-limitLines <int>`: Limita o número de linhas de diff por arquivo (padrão: 0 = sem limite)
- `-help`: Exibe a ajuda detalhada

**Exemplos**:
```powershell
# Diff básico
gitdiff-working

# Ignorar arquivos específicos
gitdiff-working -ignore "*.log, *.tmp, config.json"

# Limitar linhas por arquivo
gitdiff-working -limitLines 100

# Ver ajuda
gitdiff-working -help
```

---

### gitdiff-staged

**Descrição**: Gera um diff de todas as alterações preparadas (staged) e o exibe em um arquivo de texto temporário.

**Sintaxe**:
```powershell
gitdiff-staged
```

**Exemplos**:
```powershell
# Diff de arquivos staged
gitdiff-staged
```

---

### gitdiff-branches

**Descrição**: Gera um diff entre duas branches e o exibe em um arquivo de texto temporário.

**Sintaxe**:
```powershell
gitdiff-branches [-target <branch>] [-source <branch>] [-ignore <string>] [-help]
```

**Parâmetros**:
- `-target <branch>`: Branch de destino (padrão: master)
- `-source <branch>`: Branch de origem (padrão: branch atual)
- `-ignore <string>`: Lista de arquivos ou padrões para ignorar
- `-help`: Exibe a ajuda detalhada

**Exemplos**:
```powershell
# Comparar com master
gitdiff-branches

# Comparar branches específicas
gitdiff-branches -target develop -source feature/login

# Ignorar arquivos específicos
gitdiff-branches -ignore "*.md, *.log"
```

---

### gitstash-show

**Descrição**: Exibe um stash específico em um arquivo de texto temporário.

**Sintaxe**:
```powershell
gitstash-show [-stash <ref>]
```

**Parâmetros**:
- `-stash <ref>`: Referência do stash (padrão: stash@{0})

**Exemplos**:
```powershell
# Mostrar stash atual
gitstash-show

# Mostrar stash específico
gitstash-show -stash "stash@{2}"
```

---

### gitstash-triple

**Descrição**: Cria três stashes separados a partir do estado de trabalho atual: um para alterações preparadas (staged), um para não preparadas (unstaged) e um para a combinação de ambas.

**Sintaxe**:
```powershell
gitstash-triple [-name <string>] [-help]
```

**Parâmetros**:
- `-name <string>`: Nome descritivo para o conjunto de stashes (padrão: Stash)
- `-help`: Exibe a ajuda detalhada

**Exemplos**:
```powershell
# Criar stashes com nome padrão
gitstash-triple

# Criar stashes com nome específico
gitstash-triple -name "refatorando-login"
```

---

## System Commands

### refreshProfile

**Descrição**: Recarrega o profile do PowerShell, aplicando todas as mudanças recentes.

**Sintaxe**:
```powershell
refreshProfile [-Silent] [-Help]
```

**Parâmetros**:
- `-Silent`: Executa sem exibir mensagens de status
- `-Help`: Exibe a ajuda detalhada

**Exemplos**:
```powershell
# Recarregar com feedback
refreshProfile

# Recarregar silenciosamente
refreshProfile -Silent

# Ver ajuda
refreshProfile -Help
```

---

### tree-show

**Descrição**: Exibe a estrutura de diretórios usando tree em um arquivo temporário.

**Sintaxe**:
```powershell
tree-show
```

**Exemplos**:
```powershell
# Mostrar estrutura do diretório atual
tree-show
```

---

### project-dump

**Descrição**: Gera um mapa completo do diretório incluindo estrutura e conteúdo dos arquivos.

**Sintaxe**:
```powershell
project-dump [-Path <string>] [-IgnoreDirs <string[]>] [-ExcludeBinary] [-MaxSizeKB <int>]
```

**Parâmetros**:
- `-Path <string>`: Caminho do projeto (padrão: diretório atual)
- `-IgnoreDirs <string[]>`: Diretórios para ignorar
- `-ExcludeBinary`: Excluir arquivos binários do diagrama
- `-MaxSizeKB <int>`: Tamanho máximo de arquivo em KB (padrão: 5120)

**Exemplos**:
```powershell
# Dump do projeto atual
project-dump

# Dump de projeto específico
project-dump -Path "C:\MeuProjeto"

# Excluir arquivos binários
project-dump -ExcludeBinary

# Limitar tamanho de arquivos
project-dump -MaxSizeKB 1024
```

---

### ListFilesWithContent

**Descrição**: Lista arquivos em um diretório e exibe seu conteúdo em um arquivo temporário, com filtros de extensão e limite de tamanho.

**Sintaxe**:
```powershell
ListFilesWithContent [-Path <string>] [-IncludeExtensions <string[]>] [-ExcludeExtensions <string[]>] [-MaxFileSizeKB <int>] [-Help]
```

**Parâmetros**:
- `-Path <string>`: Caminho do diretório a ser analisado (padrão: diretório atual)
- `-IncludeExtensions <string[]>`: Extensões de arquivo a incluir (padrão: ps1, txt, md, json, xml, config)
- `-ExcludeExtensions <string[]>`: Extensões de arquivo a excluir (padrão: exe, dll, pdb, zip, 7z)
- `-MaxFileSizeKB <int>`: Tamanho máximo do arquivo em KB (padrão: 100)
- `-Help`: Exibe a ajuda detalhada

**Exemplos**:
```powershell
# Listar arquivos do diretório atual
ListFilesWithContent

# Listar arquivos de diretório específico
ListFilesWithContent -Path "C:\MeuProjeto"

# Incluir apenas arquivos PowerShell e Markdown
ListFilesWithContent -IncludeExtensions "*.ps1", "*.md"

# Excluir arquivos binários
ListFilesWithContent -ExcludeExtensions "*.exe", "*.dll"

# Limitar tamanho de arquivos
ListFilesWithContent -MaxFileSizeKB 50

# Ver ajuda
ListFilesWithContent -Help
```

---

## 🔧 Configuração

Todos os comandos são carregados automaticamente quando o PowerShell inicia. Para recarregar manualmente:

```powershell
refreshProfile
```

## 📝 Notas

- Todos os comandos que geram arquivos temporários os salvam em `$env:TEMP`
- Os arquivos são abertos automaticamente no Bloco de Notas
- Use `-help` em qualquer comando para ver a ajuda detalhada
- Os comandos incluem tratamento de erros robusto 
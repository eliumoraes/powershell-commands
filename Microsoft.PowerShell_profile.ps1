# Mensagem ao iniciar o PowerShell
Write-Host "Que tudo em mim seja para a glória de Deus. Senhor, eu clamo por luz, sabedoria e direção." -ForegroundColor Green
Write-Host "Que Deus Ilumine meu dia!" -ForegroundColor Green
Write-Host ""

# Menu de comandos compacto
function Show-CompactMenu {
    $version = "v1.0.0"
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                              COMANDOS DISPONÍVEIS                            ║" -ForegroundColor Cyan
    Write-Host "║                                    $version                                    ║" -ForegroundColor Cyan
    Write-Host "╠══════════════════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan

    # Seção: Comandos Git Diff
    Write-Host "║  [GIT DIFF]                                                                  ║" -ForegroundColor Yellow
    Write-Host "║    • gitdiff-working [-ignore '...'] [-limitLines n] [-help]                 ║" -ForegroundColor White
    Write-Host "║      Diff de arquivos não preparados (working directory)                     ║" -ForegroundColor Gray
    Write-Host "║    • gitdiff-staged [-help]                                                  ║" -ForegroundColor White
    Write-Host "║      Diff de arquivos preparados (staged)                                    ║" -ForegroundColor Gray
    Write-Host "║    • gitdiff-branches [-target <branch>] [-source <branch>] [-ignore '...']  ║" -ForegroundColor White
    Write-Host "║      Diff entre duas branches                                                ║" -ForegroundColor Gray

    # Seção: Comandos Git Stash
    Write-Host "║                                                                              ║" -ForegroundColor Cyan
    Write-Host "║  [GIT STASH]                                                                 ║" -ForegroundColor Yellow
    Write-Host "║    • gitstash-show [-stash <ref>] [-help]                                    ║" -ForegroundColor White
    Write-Host "║      Exibe um stash em arquivo temporário                                    ║" -ForegroundColor Gray
    Write-Host "║    • gitstash-triple [-name <string>] [-help]                                ║" -ForegroundColor White
    Write-Host "║      Cria três stashes separados (complete, unstaged, staged)                ║" -ForegroundColor Gray

    # Seção: Comandos de Sistema
    Write-Host "║                                                                              ║" -ForegroundColor Cyan
    Write-Host "║  [SISTEMA]                                                                   ║" -ForegroundColor Yellow
    Write-Host "║    • refreshProfile                                                          ║" -ForegroundColor White
    Write-Host "║      Limpa e recarrega o profile                                             ║" -ForegroundColor Gray
    Write-Host "║    • tree-show                                                               ║" -ForegroundColor White
    Write-Host "║      Exibe estrutura de diretórios usando tree                               ║" -ForegroundColor Gray
    Write-Host "║    • project-dump [-Path <pasta>] [-ExcludeBinary] [-MaxSizeKB <n>]          ║" -ForegroundColor White
    Write-Host "║      Gera mapa completo do diretório                                         ║" -ForegroundColor Gray
    Write-Host "║    • ListFilesWithContent                                                    ║" -ForegroundColor White
    Write-Host "║      Lista arquivos e conteúdo                                               ║" -ForegroundColor Gray

    Write-Host "╠══════════════════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
    Write-Host "║  DICA: Use -help em qualquer comando para ver ajuda detalhada                ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

# Chama a função para exibir o menu compacto
Show-CompactMenu

# Função melhorada para recarregar o profile
function refreshProfile {
    [CmdletBinding()]
    param(
        [switch]$Silent,
        [switch]$Help
    )
    
    if ($Help) {
        Write-Host "NOME" -ForegroundColor Cyan
        Write-Host "    refreshProfile"
        Write-Host ""
        Write-Host "SINOPSIS" -ForegroundColor Cyan
        Write-Host "    Recarrega o profile do PowerShell, aplicando todas as mudanças recentes."
        Write-Host ""
        Write-Host "DESCRIÇÃO" -ForegroundColor Cyan
        Write-Host "    Esta função limpa a tela e recarrega o profile do PowerShell, garantindo"
        Write-Host "    que todas as funções, aliases e variáveis definidas no profile estejam"
        Write-Host "    disponíveis na sessão atual."
        Write-Host ""
        Write-Host "PARÂMETROS" -ForegroundColor Cyan
        Write-Host "    -Silent"
        Write-Host "        Executa sem exibir mensagens de status."
        Write-Host ""
        Write-Host "    -Help"
        Write-Host "        Exibe esta mensagem de ajuda."
        Write-Host ""
        Write-Host "EXEMPLOS" -ForegroundColor Cyan
        Write-Host "    refreshProfile"
        Write-Host "        Recarrega o profile com feedback visual"
        Write-Host ""
        Write-Host "    refreshProfile -Silent"
        Write-Host "        Recarrega o profile silenciosamente"
        return
    }
    
    try {
        if (-not $Silent) {
            Write-Host "Recarregando profile do PowerShell..." -ForegroundColor Yellow
        }
        
        # Limpa a tela
        Clear-Host
        
        # Verifica se o profile existe
        if (-not (Test-Path $PROFILE)) {
            Write-Error "Profile não encontrado em: $PROFILE"
            return
        }
        
        # Remove todas as funções e aliases definidos no profile atual
        # para evitar conflitos
        Get-ChildItem function: | Where-Object { 
            $_.Source -eq $PROFILE -or $_.Source -eq "Microsoft.PowerShell_profile.ps1" 
        } | Remove-Item -Force -ErrorAction SilentlyContinue
        
        # Recarrega o profile
        . $PROFILE
        
        if (-not $Silent) {
            Write-Host "Profile recarregado com sucesso!" -ForegroundColor Green
            Write-Host "Todas as funções e aliases foram atualizados." -ForegroundColor Green
        }
        
    } catch {
        Write-Error "Erro ao recarregar o profile: $($_.Exception.Message)"
        Write-Host "Tente executar manualmente: . `$PROFILE" -ForegroundColor Yellow
    }
}


# Alias para o script ListFilesWithContent
function ListFilesWithContent {
    C:\Scripts\ListFilesWithContent.ps1
}

# Comando para diff de arquivos não preparados (working directory)
function gitdiff-working {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [switch]$help,

        [Parameter(Mandatory=$false)]
        [string]$ignore,

        [Parameter(Mandatory=$false)]
        [int]$limitLines = 0 # 0 significa sem limite
    )

    if ($help) {
        Write-Host "NOME" -ForegroundColor Cyan
        Write-Host "    gitdiff-working"
        Write-Host ""
        Write-Host "SINOPSIS" -ForegroundColor Cyan
        Write-Host "    Gera um diff de todas as alterações não preparadas (non-staged) e o exibe"
        Write-Host "    em um arquivo de texto temporário."
        Write-Host ""
        Write-Host "DESCRIÇÃO" -ForegroundColor Cyan
        Write-Host "    Este comando executa 'git diff' para capturar todas as modificações em arquivos"
        Write-Host "    que ainda não foram adicionados à área de preparação (stage). O resultado é"
        Write-Host "    salvo em um arquivo .txt e aberto automaticamente para revisão."
        Write-Host ""
        Write-Host "PARÂMETROS" -ForegroundColor Cyan
        Write-Host "    -ignore <string>"
        Write-Host "        Uma lista de nomes de arquivos ou padrões com curinga (wildcard) separados"
        Write-Host "        por vírgula para serem ignorados no diff. A comparação é case-insensitive"
        Write-Host "        e ignora o caminho do arquivo."
        Write-Host "        Exemplo: -ignore 'file1.cs, *.txt, another*'"
        Write-Host ""
        Write-Host "    -limitLines <int>"
        Write-Host "        Limita o número de linhas de diff exibidas para cada arquivo."
        Write-Host "        Se o diff de um arquivo for maior que o limite, ele será truncado e uma"
        Write-Host "        mensagem de aviso será adicionada."
        Write-Host "        O valor padrão é 0 (sem limite)."
        Write-Host "        Exemplo: -limitLines 100"
        Write-Host ""
        Write-Host "    -help"
        Write-Host "        Exibe esta mensagem de ajuda."
        return
    }

    # Definir caminho temporário
    $tempFilePath = "$env:TEMP\git_diff_nonstaged_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

    # Obter o diff completo
    $diffOutput = git diff

    # Dividir a saída do diff por arquivo.
    $diffsPerFile = $diffOutput -split '(?=diff --git)' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }

    $finalDiffContent = [System.Collections.Generic.List[string]]::new()

    # Processar -ignore
    $ignorePatterns = @()
    if (-not [string]::IsNullOrEmpty($ignore)) {
        $ignorePatterns = $ignore.Split(',') | ForEach-Object { $_.Trim().ToLower() }
    }

    foreach ($fileDiff in $diffsPerFile) {
        # Extrair o nome do arquivo
        $fileNameMatch = [regex]::Match($fileDiff, ' b/(.+)')
        if (-not $fileNameMatch.Success) {
            $finalDiffContent.Add($fileDiff)
            continue
        }
        $fileName = [System.IO.Path]::GetFileName($fileNameMatch.Groups[1].Value).ToLower()

        # Verificar se o nome do arquivo corresponde a algum dos padrões de ignore
        $isIgnored = $false
        foreach ($pattern in $ignorePatterns) {
            if ($fileName -like $pattern) {
                $isIgnored = $true
                break
            }
        }

        if ($isIgnored) {
            continue
        }

        # Processar -limitLines
        $diffLines = $fileDiff.Split([Environment]::NewLine)
        if ($limitLines -gt 0 -and $diffLines.Count -gt $limitLines) {
            $truncatedDiff = $diffLines[0..($limitLines - 1)]
            $finalDiffContent.AddRange($truncatedDiff)
            $finalDiffContent.Add("`n[... Diff truncado em $limitLines linhas. O arquivo completo contém mais alterações. ...]`n")
        } else {
            $finalDiffContent.Add($fileDiff)
        }
    }

    # Salvar e abrir
    ($finalDiffContent -join [Environment]::NewLine) | Out-File -FilePath $tempFilePath -Encoding UTF8
    Write-Host "Arquivo temporário salvo em: $tempFilePath" -ForegroundColor Cyan
    notepad $tempFilePath
}

# Comando para diff de arquivos preparados (staged)
function gitdiff-staged {
    # Definir caminho temporário para salvar o arquivo
    $tempFilePath = "$env:TEMP\git_diff_staged_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

    # Redirecionar a saída do git diff --staged para o arquivo temporário sem usar GIT_PAGER
    git diff --staged | Out-File -FilePath $tempFilePath -Encoding UTF8

    # Mostrar caminho e abrir o arquivo no Bloco de Notas
    Write-Host "Arquivo temporário salvo em: $tempFilePath" -ForegroundColor Cyan
    notepad $tempFilePath
}

# Alias para o comando tree
# function treedump {
    # $tempFilePath = "$env:TEMP\tree_output_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

    # tree | Out-File -FilePath $tempFilePath -Encoding UTF8
	
    # notepad $tempFilePath
# }

function tree-show {
    $tempFilePath = "$env:TEMP/tree_output_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $currentPath = (Get-Location).Path
    "PWD: $currentPath`n" | Out-File -FilePath $tempFilePath -Encoding UTF8

    # Captura a saída do tree e filtra apenas linhas de diretório
    $lines = cmd /c "tree /a" | Where-Object { $_ -match '[\+\|\\]---' }

    $result = @()
    $skipDepth = $null

    foreach ($line in $lines) {
        $pos = $line.IndexOf('---')
        # se estamos dentro de um subtree Debug e ainda não voltamos
        if ($skipDepth -ne $null -and $pos -gt $skipDepth) {
            continue
        }
        # se voltamos acima do Debug
        if ($skipDepth -ne $null -and $pos -le $skipDepth) {
            $skipDepth = $null
        }
        # linha Debug: incluir e marcar profundidade para skip
        if ($line -match 'Debug') {
            $result += $line
            $skipDepth = $pos
            continue
        }
        # linha normal: incluir
        $result += $line
    }

    # Grava e abre
    $result | Out-File -Append -FilePath $tempFilePath -Encoding UTF8
    Write-Host "Arquivo temporário salvo em: $tempFilePath" -ForegroundColor Cyan
    notepad $tempFilePath
}

# Comando para exibir stash em arquivo temporário
function gitstash-show {

# Como usar:
# Para ver o diff do stash padrão (ou seja, stash@{0}):
# gitstashdiff
# Para ver o diff de outro stash (por exemplo, stash@{2}), execute:
# gitstashdiff "stash@{2}"


    param(
        [Parameter(Mandatory=$false)]
        [string]$stash = "stash@{0}"
    )

    # Define o caminho temporário para salvar o arquivo
    $tempFilePath = "$env:TEMP\git_stash_diff_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

    # Executa o comando git stash show -p com o stash informado (atenção aos caracteres especiais com aspas)
    git stash show -p "$stash" | Out-File -FilePath $tempFilePath -Encoding UTF8

    # Mostrar caminho e abrir o arquivo no Bloco de Notas
    Write-Host "Arquivo temporário salvo em: $tempFilePath" -ForegroundColor Cyan
    notepad $tempFilePath
}


## Comando para criar três stashes separados
function gitstash-triple {
    param(
        [Parameter(Mandatory=$false)]
        [string]$Name = "Stash",
        [Parameter(Mandatory=$false)]
        [switch]$help
    )
    
    if ($help) {
        Write-Host "NOME" -ForegroundColor Cyan
        Write-Host "    gitstash-triple"
        Write-Host ""
        Write-Host "SINOPSIS" -ForegroundColor Cyan
        Write-Host "    Cria três stashes distintos a partir do estado de trabalho atual: um para"
        Write-Host "    alterações preparadas (staged), um para não preparadas (unstaged) e um"
        Write-Host "    para a combinação de ambas."
        Write-Host ""
        Write-Host "DESCRIÇÃO" -ForegroundColor Cyan
        Write-Host "    Este comando automatiza o processo de separação do seu trabalho em andamento."
        Write-Host "    É útil quando você precisa salvar o progresso, mas quer manter as alterações"
        Write-Host "    preparadas e não preparadas isoladas para aplicá-las seletivamente mais tarde."
        Write-Host ""
        Write-Host "    Os stashes são nomeados com a mensagem fornecida no parâmetro -Name para"
        Write-Host "    fácil identificação:"
        Write-Host "    - <nome> - complete stash"
        Write-Host "    - <nome> - unstaged stash"
        Write-Host "    - <nome> - staged stash"
        Write-Host ""
        Write-Host "EXEMPLOS" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    --- Exemplo 1: Criar os stashes ---" -ForegroundColor Yellow
        Write-Host "    gitstash-triple -Name "refatorando-login""
        Write-Host ""
        Write-Host "    Isso irá gerar três stashes com o prefixo 'refatorando-login'."
        Write-Host ""
        Write-Host "    --- Exemplo 2: Listar e recuperar um stash ---" -ForegroundColor Yellow
        Write-Host "    Após executar o comando, liste os stashes disponíveis:"
        Write-Host "    git stash list"
        Write-Host ""
        Write-Host "    A saída será parecida com:"
        Write-Host "    stash@{0}: On main: refatorando-login - staged stash"
        Write-Host "    stash@{1}: On main: refatorando-login - unstaged stash"
        Write-Host "    stash@{2}: On main: refatorando-login - complete stash"
        Write-Host ""
        Write-Host "    Para aplicar apenas as alterações que já estavam preparadas (staged):"
        Write-Host "    git stash apply stash@{0}"
        Write-Host ""
        Write-Host "PARÂMETROS" -ForegroundColor Cyan
        Write-Host "    -Name <string>"
        Write-Host "        Um nome descritivo para o conjunto de stashes. O padrão é 'Stash'."
        Write-Host ""
        Write-Host "    -help"
        Write-Host "        Exibe esta mensagem de ajuda."
        return
    }
    
    Write-Host "Iniciando tripleStash..." -ForegroundColor Green

    # 1. Cria o stash completo (staged + unstaged + untracked) como backup.
    Write-Host "1/4: Salvando stash completo (incluindo arquivos não rastreados)..." -ForegroundColor Green
    git stash push -u -m "$Name - complete stash"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Nenhuma alteração encontrada para salvar. Abortando." -ForegroundColor Yellow
        return
    }
    
    # 2. Restaura o estado original para podermos separar as alterações.
    Write-Host "2/4: Restaurando estado de trabalho para separação..." -ForegroundColor Green
    git stash apply --index 'stash@{0}'
    
    # 3. Cria o stash 'unstaged'.
    # Primeiro, fazemos um commit temporário do que está no 'stage'.
    git commit -m "tmp-triple-stash-staged" --no-verify
    # Agora, o que sobrou (unstaged e untracked) é salvo no stash 'unstaged'.
    Write-Host "3/4: Salvando stash de alterações não preparadas (unstaged)..." -ForegroundColor Green
    git stash push -u -m "$Name - unstaged stash"
    
    # 4. Cria o stash 'staged' e limpa o diretório.
    # Desfazemos o commit temporário, trazendo as alterações de volta para o 'stage' (o diretório continua limpo).
    git reset --soft HEAD~1
    # Agora que apenas as alterações 'staged' existem no index, salvamos no stash 'staged'.
    # Este comando final também limpa o stage, deixando o diretório 100% limpo.
    Write-Host "4/4: Salvando stash de alterações preparadas (staged) e limpando..." -ForegroundColor Green
    git stash push -m "$Name - staged stash"
    
    Write-Host ""
    Write-Host "Stashes criados com sucesso:" -ForegroundColor Cyan
    git --no-pager stash list --format="%gd %s"
    Write-Host ""
    Write-Host "Para aplicar um stash, use:" -ForegroundColor Cyan
    Write-Host "  git stash apply <ref>"
    Write-Host "Exemplo: git stash apply stash@{n}"
}

## Comando para diff entre branches
function gitdiff-branches {
    param(
        [string]$TargetBranch  = "master",
        [string]$SourceBranch  = $null,
        [string]$ignore,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "NOME" -ForegroundColor Cyan
        Write-Host "    gitdiff-branches"
        Write-Host ""
        Write-Host "SINOPSIS" -ForegroundColor Cyan
        Write-Host "    Gera um diff entre duas branches e o exibe em um arquivo de texto temporário."
        Write-Host ""
        Write-Host "DESCRIÇÃO" -ForegroundColor Cyan
        Write-Host "    Este comando executa 'git diff' para comparar duas branches e capturar todas"
        Write-Host "    as diferenças entre elas. O resultado é salvo em um arquivo .txt e aberto"
        Write-Host "    automaticamente para revisão."
        Write-Host ""
        Write-Host "PARÂMETROS" -ForegroundColor Cyan
        Write-Host "    -TargetBranch <string>"
        Write-Host "        A branch de destino para comparação. O padrão é 'master'."
        Write-Host "        Exemplo: -TargetBranch 'develop'"
        Write-Host ""
        Write-Host "    -SourceBranch <string>"
        Write-Host "        A branch de origem para comparação. Se não especificado, compara a branch"
        Write-Host "        atual com a branch remota (origin/master)."
        Write-Host "        Exemplo: -SourceBranch 'feature/login'"
        Write-Host ""
        Write-Host "    -ignore <string>"
        Write-Host "        Uma lista de nomes de arquivos ou padrões com curinga (wildcard) separados"
        Write-Host "        por vírgula para serem ignorados no diff. A comparação é case-insensitive."
        Write-Host "        Exemplo: -ignore '*.md, *.log, *.txt'"
        Write-Host ""
        Write-Host "    -Help"
        Write-Host "        Exibe esta mensagem de ajuda."
        Write-Host ""
        Write-Host "EXEMPLOS" -ForegroundColor Cyan
        Write-Host "    gitdiff-branches"
        Write-Host "        Compara a branch atual com origin/master (master remota)"
        Write-Host ""
        Write-Host "    gitdiff-branches -TargetBranch develop -SourceBranch feature/new-feature"
        Write-Host "        Compara a branch 'feature/new-feature' com 'develop'"
        Write-Host ""
        Write-Host "    gitdiff-branches -ignore '*.md, *.log'"
        Write-Host "        Compara a branch atual com master, ignorando arquivos .md e .log"
        return
    }

    # 1) Atualiza referências e detecta branch atual se não informado
    git fetch
    if (-not $SourceBranch) {
        $SourceBranch = git rev-parse --abbrev-ref HEAD
    }

    # 2) Sanitiza barras para _  
    $safeSource = $SourceBranch -replace '[\\/]', '_'
    $safeTarget = $TargetBranch  -replace '[\\/]', '_'

    # 3) Timestamp para data+hora  
    $ts = Get-Date -Format "yyyyMMdd_HHmmss"

    # 4) Monta nome do arquivo e caminho completo  
    $fileName = "git_diff_branch_${safeSource}_vs_${safeTarget}_$ts.txt"
    $filePath = Join-Path -Path $env:TEMP -ChildPath $fileName

    # 5) Gera o diff completo
    # Sempre compara com a branch remota (origin/master) quando não especificado SourceBranch
    $diffOutput = git --no-pager diff origin/$TargetBranch...HEAD
    # Se não há diferenças entre branches, inclui staged changes
    if ([string]::IsNullOrWhiteSpace($diffOutput)) {
        Write-Host "Nenhuma diferença encontrada entre branches. Incluindo staged changes..." -ForegroundColor Yellow
        $diffOutput = git --no-pager diff --cached
    }

    # 6) Filtra a saída se -ignore for usado
    $finalDiffContent = ""
    $ignorePatterns = @()
    if (-not [string]::IsNullOrEmpty($ignore)) {
        $ignorePatterns = $ignore.Split(',') | ForEach-Object { $_.Trim().ToLower() }
    }

    if ($ignorePatterns.Count -eq 0) {
        $finalDiffContent = $diffOutput
    } else {
        $diffsPerFile = $diffOutput -split '(?=diff --git)' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
        $filteredDiffs = [System.Collections.Generic.List[string]]::new()

        foreach ($fileDiff in $diffsPerFile) {
            # Extrair o nome do arquivo do diff
            $fileNameMatch = [regex]::Match($fileDiff, ' b/(.+)')
            if (-not $fileNameMatch.Success) {
                $filteredDiffs.Add($fileDiff)
                continue
            }
            
            $fileNameFromDiff = [System.IO.Path]::GetFileName($fileNameMatch.Groups[1].Value).ToLower()

            # Verificar se o nome do arquivo corresponde a algum dos padrões de ignore
            $isIgnored = $false
            foreach ($pattern in $ignorePatterns) {
                if ($fileNameFromDiff -like $pattern) {
                    $isIgnored = $true
                    break
                }
            }

            if (-not $isIgnored) {
                $filteredDiffs.Add($fileDiff)
            }
        }
        $finalDiffContent = $filteredDiffs -join [Environment]::NewLine
    }

    # 7) Salva e abre
    $finalDiffContent | Out-File -FilePath $filePath -Encoding UTF8
    Write-Host "Arquivo temporário salvo em: $filePath" -ForegroundColor Cyan
    notepad $filePath
}

## Alias para o projectDump
# function projectDump {
    # param(
        # [string]$Path         = (Get-Location),
        # [string[]]$IgnoreDirs = @('bin','obj', 'Debug'),   # adicione mais aqui
        # [switch]$ExcludeBinary,
        # [int]   $MaxSizeKB    = 5120
    # )

    # $ts      = Get-Date -Format "yyyyMMdd_HHmmss"
    # $output  = Join-Path $env:TEMP "project_dump_$ts.txt"
    # $lines   = @()

    # # Cabeçalho
    # $lines += '### Diretório raiz'
    # $lines += (Resolve-Path $Path).Path
    # $lines += ''

    # # Estrutura
    # $lines += '### Estrutura (tree /f)'
    # $lines += ''
    # $lines += (cmd /c "tree `"$Path`" /f /a")  # /a = ASCII, evita caracteres estranhos
    # $lines += ''

    # # Regex para pular diretórios ignorados
    # $ignoredPattern = '\\(' + ($IgnoreDirs -join '|') + ')(\\|$)'

    # # Arquivos
    # $lines += '### Conteúdo dos arquivos'
    # $lines += ''

    # $files = Get-ChildItem $Path -Recurse -File |
             # Where-Object { $_.FullName -notmatch $ignoredPattern }

    # foreach ($f in $files) {
        # if ($ExcludeBinary -and $f.Extension -match '\.(exe|dll|png|jpe?g|gif|ico|zip|pdb)$') { continue }
        # if ($f.Length/1KB -gt $MaxSizeKB)                                             { continue }

        # $lines += "----- BEGIN $($f.FullName) -----"
        # try   { $lines += Get-Content $f.FullName -Raw }
        # catch { $lines += '<Erro ao ler arquivo>' }
        # $lines += "----- END   $($f.FullName) -----"
        # $lines += ''
    # }

    # $lines | Set-Content -Encoding utf8 $output
    # notepad $output
# }

## Comando para gerar dump completo do projeto
function project-dump {
    [CmdletBinding()]
    param(
        [string]$Path = (Get-Location).Path,
        [string[]]$IgnoreDirs = @('bin', 'obj', 'Debug', '.git', '.vs', 'node_modules', '.idea'),
        [switch]$ExcludeBinary,
        [int]$MaxSizeKB = 5120
    )

    # --- SETUP INICIAL ---
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $outputFile = Join-Path $env:TEMP "project_dump_$timestamp.txt"
    $outputLines = [System.Collections.Generic.List[string]]::new()
    $binaryExtensionsRegex = '\.(exe|dll|pdb|png|jpe?g|gif|ico|zip|nupkg|snk|cer|p12|so|dylib)$'
    $resolvedPath = (Resolve-Path -LiteralPath $Path).Path

    # --- FUNÇÃO HELPER RECURSIVA PARA CONSTRUIR A ÁRVORE ---
    function Get-ProjectTree {
        param (
            [string]$CurrentPath,
            [string]$Indent
        )

        # <<<<<<<<<<<<<<< LÓGICA TOTALMENTE REFEITA E CORRIGIDA >>>>>>>>>>>>>
        # Busca os filhos diretos do diretório atual, já aplicando a exclusão de pastas.
        try {
            $children = Get-ChildItem -Path $CurrentPath -Exclude $IgnoreDirs -ErrorAction SilentlyContinue
        } catch { return } # Se não conseguir listar, simplesmente retorna.

        $childItems = $children | Sort-Object -Property @{E={$_.PSIsContainer}; D=$true}, Name
        $lastItem = $childItems[-1]

        foreach ($item in $childItems) {
            $isLast = $item.FullName -eq $lastItem.FullName
            $prefix = if ($isLast) { "L--- " } else { "|--- " }
            $childIndent = if ($isLast) { "$Indent    " } else { "$Indent|   " }

            if ($item.PSIsContainer) {
                # Se for um diretório, adiciona ao diagrama e chama a recursão.
                $outputLines.Add("$Indent$prefix$($item.Name)/")
                Get-ProjectTree -CurrentPath $item.FullName -Indent $childIndent
            } else {
                # Se for um arquivo, verifica se deve ser excluído do diagrama.
                if (-not ($ExcludeBinary.IsPresent -and $item.Name -match $binaryExtensionsRegex)) {
                    $sizeInfo = "[$(($item.Length / 1KB).ToString('N2')) KB]"
                    $outputLines.Add("$Indent$prefix$($item.Name) $sizeInfo")
                }
            }
        }
    }

    # --- ETAPA 1: Construir o DIAGRAMA ---
    Write-Host "1. Gerando o diagrama do projeto..." -ForegroundColor Yellow
    $outputLines.Add("### Diagrama do Projeto")
    $outputLines.Add("Diretório Raiz: $resolvedPath")
    $outputLines.Add("Diretórios Ignorados: $($IgnoreDirs -join ', ')")
    $outputLines.Add("Arquivos Binários Excluídos do Diagrama: $(if($ExcludeBinary.IsPresent) {'Sim'} else {'Não'})")
    $outputLines.Add("")
    
    $outputLines.Add((Get-Item -LiteralPath $resolvedPath).Name + "/")
    Get-ProjectTree -CurrentPath $resolvedPath -Indent ""
    $outputLines.Add("")

    # --- ETAPA 2: Adicionar o CONTEÚDO DOS ARQUIVOS ---
    Write-Host "2. Coletando conteúdo dos arquivos de texto..." -ForegroundColor Yellow
    $outputLines.Add("### Conteúdo dos Arquivos")
    $outputLines.Add("")
    
    # Busca todos os arquivos válidos para o dump de conteúdo, ignorando os diretórios
    $ignorePattern = '(?i)\\((' + ($IgnoreDirs -join '|') + '))\b'
    $filesToDump = Get-ChildItem -Path $resolvedPath -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notmatch $ignorePattern }

    foreach ($file in $filesToDump) {
        if ($file.Name -match $binaryExtensionsRegex) { continue }
        if (($file.Length / 1KB) -gt $MaxSizeKB) {
            $sizeInKB = [math]::Round($file.Length / 1KB, 2)
            $outputLines.Add("----- CONTEÚDO OMITIDO (Tamanho: ${sizeInKB}KB > ${MaxSizeKB}KB): $($file.FullName) -----")
            $outputLines.Add("")
            continue
        }
        
        $outputLines.Add("----- BEGIN: $($file.FullName) -----")
        try {
            $outputLines.Add((Get-Content -Path $file.FullName -Raw -ErrorAction Stop))
        } catch {
            $outputLines.Add("<ERRO AO LER O ARQUIVO: $($_.Exception.Message)>")
        }
        $outputLines.Add("----- END: $($file.FullName) -----")
        $outputLines.Add("")
    }

    # --- ETAPA 3: Gravar e Finalizar ---
    Write-Host "3. Gravando o arquivo de saída..." -ForegroundColor Yellow
    [System.IO.File]::WriteAllLines($outputFile, $outputLines, [System.Text.Encoding]::UTF8)

    $stopwatch.Stop()
    Write-Host "Dump do projeto concluído em $($stopwatch.Elapsed.TotalSeconds.ToString("N2")) segundos." -ForegroundColor Green
    Write-Host "Resultado salvo em: $outputFile"
    notepad $outputFile
}
# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2024-12-20

### Added
- Sistema de configuração via `appsettings.json` para personalizar comportamento do profile
- Funcionalidade de menu minimizado: menu pode ser configurado para iniciar oculto
  - Configuração `Menu.MinimizeOnStart` no `appsettings.json` controla o comportamento
  - Comando de ativação configurável via `Menu.ActivationCommand` (padrão: `menu`)
  - Menu minimizado mostra mensagem indicando como exibir o menu completo
- Função `Show-Menu`: Comando para exibir o menu completo quando minimizado
- Detecção automática de suporte Unicode para melhor renderização do menu
  - Fallback para caracteres ASCII quando Unicode não é suportado adequadamente
  - Melhora compatibilidade com diferentes versões do PowerShell
- Nova implementação completa da função `ListFilesWithContent` com filtros de extensão e limite de tamanho
- Função `move-windows-to-main-monitor` (alias: `mwm`): Move todas as janelas visíveis para o monitor principal
  - Restaura janelas minimizadas automaticamente
  - Redimensiona janelas grandes para caber no monitor principal
  - Verifica se janelas ficaram completamente no monitor após mover
  - Usa Win32 API SetWindowPos para maior confiabilidade

### Changed
- Função `Show-CompactMenu` refatorada para melhor renderização em diferentes versões do PowerShell
  - Detecção automática de suporte Unicode
  - Renderização adaptativa baseada nas capacidades do terminal
  - Melhor alinhamento e formatação do menu
- Função `gitdiff-branches` agora sempre mostra estado completo do working directory
- Sistema de filtragem de extensões na função `ListFilesWithContent` melhorado

### Fixed
- Correção crítica de renderização do menu em versões antigas do PowerShell
  - Detecção melhorada de suporte Unicode baseada em versão do PowerShell e tipo de terminal
  - Fallback automático para caracteres ASCII quando Unicode não é suportado
  - Menu agora renderiza corretamente em PowerShell 5.1 no console padrão do Windows
  - Substituição de caracteres Unicode problemáticos (bullet •) por ASCII (*) quando necessário
  - Função helper `Format-MenuLine` para garantir alinhamento correto em todos os casos
  - Remoção de acentos problemáticos em textos do menu para melhor compatibilidade
- Correção crítica na função `gitdiff-branches` que retornava arquivos vazios
- Correção de bug na lógica de filtragem de extensões que impedia encontrar arquivos
- Substituição de alias quebrado `ListFilesWithContent` por implementação funcional

## [1.1.0] - 2024-12-19

### Added
- Melhorias nas funções gitdiff-branches e ListFilesWithContent

## [1.0.0] - 2024-12-19

### Added
- Comandos Git Diff:
  - `gitdiff-working`: Diff de arquivos não preparados
  - `gitdiff-staged`: Diff de arquivos preparados
  - `gitdiff-branches`: Diff entre duas branches
- Comandos Git Stash:
  - `gitstash-show`: Exibe stash em arquivo temporário
  - `gitstash-triple`: Cria três stashes separados
- Comandos de Sistema:
  - `refreshProfile`: Recarrega o profile
  - `tree-show`: Exibe estrutura de diretórios
  - `project-dump`: Gera mapa completo do diretório
  - `ListFilesWithContent`: Lista arquivos e conteúdo
- Menu de comandos organizado por categoria
- Sistema de ajuda integrado (-help) para todos os comandos

### Features
- Interface visual elegante com bordas Unicode
- Cores diferenciadas para melhor legibilidade
- Tratamento de erros robusto
- Documentação inline para todos os comandos

---

## Tipos de Mudanças

- **Added** para novas funcionalidades
- **Changed** para mudanças em funcionalidades existentes
- **Deprecated** para funcionalidades que serão removidas
- **Removed** para funcionalidades removidas
- **Fixed** para correções de bugs
- **Security** para correções de vulnerabilidades 
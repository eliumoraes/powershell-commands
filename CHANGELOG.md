# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Nova implementação completa da função `ListFilesWithContent` com filtros de extensão e limite de tamanho

### Changed
- Função `gitdiff-branches` agora sempre mostra estado completo do working directory
- Sistema de filtragem de extensões na função `ListFilesWithContent` melhorado

### Fixed
- Correção crítica na função `gitdiff-branches` que retornava arquivos vazios
- Correção de bug na lógica de filtragem de extensões que impedia encontrar arquivos
- Substituição de alias quebrado `ListFilesWithContent` por implementação funcional

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
# 🚀 PowerShell Commands Collection

Uma coleção de comandos e funções PowerShell úteis para desenvolvimento e administração de sistemas.

## 📋 Sobre

Este repositório contém comandos PowerShell customizados que facilitam tarefas comuns de desenvolvimento, especialmente relacionadas ao Git e análise de projetos.

## 🎯 Funcionalidades

### Git Commands
- **gitdiff-working**: Diff de arquivos não preparados (working directory)
- **gitdiff-staged**: Diff de arquivos preparados (staged)
- **gitdiff-branches**: Diff entre duas branches
- **gitstash-show**: Exibe um stash em arquivo temporário
- **gitstash-triple**: Cria três stashes separados (complete, unstaged, staged)

### System Commands
- **refreshProfile**: Limpa e recarrega o profile
- **tree-show**: Exibe estrutura de diretórios usando tree
- **project-dump**: Gera mapa completo do diretório
- **ListFilesWithContent**: Lista arquivos e conteúdo

## 🚀 Instalação

1. Clone o repositório:
```powershell
git clone https://github.com/seu-usuario/powershell-commands.git
```

2. Copie o arquivo de perfil:
```powershell
Copy-Item "Microsoft.PowerShell_profile.ps1" "$PROFILE"
```

3. Recarregue o PowerShell ou execute:
```powershell
. $PROFILE
```

## 📁 Estrutura do Projeto

```
powershell-commands/
├── Microsoft.PowerShell_profile.ps1  # Perfil principal
├── README.md                         # Este arquivo
├── CHANGELOG.md                      # Histórico de mudanças
├── LICENSE                           # Licença do projeto
└── docs/                            # Documentação adicional
    ├── commands/                     # Documentação dos comandos
    └── examples/                     # Exemplos de uso
```

## 🌿 Estratégia de Branch

### Branches Principais

- **`main`**: Código estável e testado
- **`develop`**: Branch de desenvolvimento
- **`feature/*`**: Novas funcionalidades
- **`hotfix/*`**: Correções urgentes
- **`release/*`**: Preparação para releases

### Fluxo de Trabalho

1. **Desenvolvimento de Features**:
   ```bash
   git checkout develop
   git checkout -b feature/nova-funcionalidade
   # Desenvolver e testar
   git push origin feature/nova-funcionalidade
   # Criar PR para develop
   ```

2. **Releases**:
   ```bash
   git checkout develop
   git checkout -b release/v1.2.0
   # Ajustar versão e changelog
   git checkout main
   git merge release/v1.2.0
   git tag v1.2.0
   git checkout develop
   git merge release/v1.2.0
   git branch -d release/v1.2.0
   ```

3. **Hotfixes**:
   ```bash
   git checkout main
   git checkout -b hotfix/correcao-urgente
   # Corrigir e testar
   git checkout main
   git merge hotfix/correcao-urgente
   git tag v1.2.1
   git checkout develop
   git merge hotfix/correcao-urgente
   git branch -d hotfix/correcao-urgente
   ```

## 🔄 Pull Request Guidelines

### Antes de Criar um PR

1. **Teste suas mudanças**:
   ```powershell
   refreshProfile
   # Teste todos os comandos modificados
   ```

2. **Atualize a documentação**:
   - README.md se necessário
   - CHANGELOG.md para novas funcionalidades
   - Documentação dos comandos

3. **Verifique o código**:
   - Sintaxe PowerShell correta
   - Comentários adequados
   - Tratamento de erros

### Template de PR

```markdown
## 📝 Descrição
Breve descrição das mudanças

## 🎯 Tipo de Mudança
- [ ] Bug fix
- [ ] Nova funcionalidade
- [ ] Breaking change
- [ ] Documentação

## ✅ Checklist
- [ ] Código testado localmente
- [ ] Documentação atualizada
- [ ] CHANGELOG.md atualizado
- [ ] Comandos funcionando corretamente

## 🧪 Como Testar
1. Execute `refreshProfile`
2. Teste os comandos modificados
3. Verifique se não há erros

## 📸 Screenshots (se aplicável)
```

## 📦 Versionamento

Seguimos [Semantic Versioning](https://semver.org/):

- **MAJOR**: Mudanças incompatíveis com versões anteriores
- **MINOR**: Novas funcionalidades compatíveis
- **PATCH**: Correções de bugs compatíveis

### Exemplo de Versionamento

- `v1.0.0`: Primeira versão estável
- `v1.1.0`: Nova funcionalidade adicionada
- `v1.1.1`: Correção de bug
- `v2.0.0`: Breaking change

## 📝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🤝 Agradecimentos

- Comunidade PowerShell
- Contribuidores do projeto

---

**Versão Atual**: v1.0.0  
**Última Atualização**: $(Get-Date -Format "dd/MM/yyyy") 
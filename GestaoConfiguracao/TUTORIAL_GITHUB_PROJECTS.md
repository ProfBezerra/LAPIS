# Tutorial: Configuração de Issues, Milestones, Sprints e Kanban por Grupo

> Guia adaptado para uso em turma — cada **grupo** usa o próprio repositório e Project.

## Sumário

- [Tutorial: Configuração de Issues, Milestones, Sprints e Kanban por Grupo](#tutorial-configuração-de-issues-milestones-sprints-e-kanban-por-grupo)
  - [Sumário](#sumário)
  - [Pré-requisitos](#pré-requisitos)
  - [Download rápido (ZIP)](#download-rápido-zip)
  - [Fluxos de execução](#fluxos-de-execução)
    - [Fluxo A (com cópia para o repositório do grupo)](#fluxo-a-com-cópia-para-o-repositório-do-grupo)
    - [Fluxo B (sem alterar o repositório do grupo)](#fluxo-b-sem-alterar-o-repositório-do-grupo)
  - [Como criar um Personal Access Token (PAT)](#como-criar-um-personal-access-token-pat)
  - [Variáveis do grupo](#variáveis-do-grupo)
  - [Baixar scripts direto do GitHub (sem clonar)](#baixar-scripts-direto-do-github-sem-clonar)
  - [Setup completo em um único script](#setup-completo-em-um-único-script)
    - [Primeira execução (com criação automática de sprints)](#primeira-execução-com-criação-automática-de-sprints)
    - [Re-sincronização (quando o JSON mudar)](#re-sincronização-quando-o-json-mudar)
    - [Teste (dry-run)](#teste-dry-run)
  - [Scripts individuais (referência)](#scripts-individuais-referência)
  - [Windows: quando o PowerShell não é reconhecido](#windows-quando-o-powershell-não-é-reconhecido)
  - [Criar view Kanban (manual)](#criar-view-kanban-manual)
  - [Checklist rápido](#checklist-rápido)
  - [Troubleshooting](#troubleshooting)
  - [Segurança](#segurança)
  - [Bloco rápido (copiar e colar)](#bloco-rápido-copiar-e-colar)
  - [Uso em sala (professor)](#uso-em-sala-professor)
  - [Próxima aula: Gestão de Configuração (projeto de requisitos)](#próxima-aula-gestão-de-configuração-projeto-de-requisitos)
    - [Entregáveis](#entregáveis)
    - [Fluxo recomendado](#fluxo-recomendado)
    - [Critérios de qualidade](#critérios-de-qualidade)
    - [Comandos úteis](#comandos-úteis)

---

## Pré-requisitos

- PowerShell (Windows)
- Token GitHub com permissões: **`repo`** (se for privado) e **`project`**

Você pode seguir **um de dois fluxos**:

- Fluxo A: copiar scripts/JSON para o repositório do grupo.
- Fluxo B: executar localmente sem alterar o repositório do grupo (baixando do GitHub no momento da execução).

---

## Download rápido (ZIP)

Baixe o arquivo `lapis-setup.zip` diretamente do repositório — ele contém `setup-project.ps1` e `issues_github.json` prontos para uso:

- **Link:** [lapis-setup.zip](https://github.com/gitserpro/lapis/raw/main/lapis-setup.zip)

Após baixar, descompacte em qualquer pasta e execute:

```powershell
$env:GITHUB_TOKEN = "SEU_TOKEN_AQUI"

Set-Location "PASTA_ONDE_DESCOMPACTOU"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

& .\setup-project.ps1 `
  -Owner SEU_USUARIO_GITHUB `
  -Repo SEU_REPOSITORIO `
  -ProjectNumber 1 `
  -Token $env:GITHUB_TOKEN `
  -AutoCreateIterationField `
  -IterationFieldName "Sprint" `
  -IterationStartDate "2026-04-13" `
  -IterationDuration 14 `
  -IterationCount 5
```

> **Nota:** o ZIP não precisa estar dentro de um repositório Git — funciona em qualquer pasta local.

---

## Fluxos de execução

O script `setup-project.ps1` realiza as duas etapas (importação e sincronização) em um único comando, simplificando o processo.

### Fluxo A (com cópia para o repositório do grupo)

O repositório do grupo contém:

- `scripts/setup-project.ps1`
- `scripts/import-github-issues.ps1` (referência)
- `scripts/sync-project-sprints.ps1` (referência)
- `scripts/issues_github.json`

### Fluxo B (sem alterar o repositório do grupo)

Você baixa os arquivos da branch `main` do repositório base para uma pasta local temporária e executa dali.

Arquivos necessários:

- `scripts/setup-project.ps1`
- `scripts/issues_github.json`

Links diretos (exemplo atual `gitserpro/lapis`):

- Pasta de scripts: [https://github.com/ProfBezerra/LAPIS/tree/main/scripts](https://github.com/ProfBezerra/LAPIS/tree/main/scripts)
- JSON de issues: [https://github.com/ProfBezerra/lapis/blob/main/scripts/issues_github.json](https://github.com/ProfBezerra/lapis/blob/main/scripts/issues_github.json)

Se o repositório base for outro, troque `gitserpro/lapis` e a branch `main` nos links.

---

## Como criar um Personal Access Token (PAT)

Siga estes passos para gerar um token com as permissões necessárias:

1. No GitHub, clique no seu avatar → **Settings**.
2. No menu lateral, abra **Developer settings** → **Personal access tokens** → **Tokens (classic)**.
3. Clique em **Generate new token (classic)**.
4. Informe um **nome/descritivo** e escolha uma **data de expiração** (recomendado).
5. Em **Select scopes**, marque pelo menos:
   - `repo` — acesso ao repositório (necessário se o repositório for privado)
   - `project` — necessário para operações em GitHub Projects v2 (use token clássico se precisar de acesso a Projects)
6. Clique em **Generate token** e **copie** o valor gerado — você não poderá vê-lo novamente.

Boas práticas:

- Guarde o token em local seguro (ex.: gerenciador de senhas) e nunca o coloque em commits.
- Use variáveis de ambiente para execução local, ex. no PowerShell:

```powershell
$env:GITHUB_TOKEN = "SEU_TOKEN_AQUI"
```

- Revogue o token imediatamente se ele for exposto e gere um novo com permissões mínimas.

---

## Variáveis do grupo

No PowerShell, defina:

```powershell
$env:GITHUB_TOKEN = "SEU_TOKEN_AQUI"

$GRUPO_OWNER = "SEU_USUARIO_GITHUB"
$GRUPO_REPO = "SEU_REPOSITORIO"
$PROJECT_OWNER = "SEU_USUARIO_GITHUB"
$PROJECT_NUMBER = 1
```

Exemplo:

```powershell
$GRUPO_OWNER = "grupo-a"
$GRUPO_REPO = "projeto-requisitos-grupo-a"
$PROJECT_OWNER = "joao-silva"
$PROJECT_NUMBER = 2
```

Se estiver usando o **Fluxo A**, entre na pasta do repositório do grupo:

```powershell
Set-Location "CAMINHO_LOCAL_DO_REPOSITORIO"
```

---

## Baixar scripts direto do GitHub (sem clonar)

Use esta seção apenas no **Fluxo B**.

1. Ajuste as variáveis abaixo para o repositório que contém os scripts base.
2. Os arquivos serão baixados para uma pasta temporária.
3. A execução do script será feita nessa pasta, sem alterar o repositório do grupo.

```powershell
$BASE_OWNER = "gitserpro"
$BASE_REPO = "lapis"
$BASE_BRANCH = "main"

$WORK_DIR = Join-Path $env:TEMP "lapis-gh-project-setup"
New-Item -ItemType Directory -Force -Path "$WORK_DIR/scripts" | Out-Null

$baseRaw = "https://raw.githubusercontent.com/$BASE_OWNER/$BASE_REPO/$BASE_BRANCH"
Invoke-WebRequest "$baseRaw/scripts/setup-project.ps1" -OutFile "$WORK_DIR/scripts/setup-project.ps1"
Invoke-WebRequest "$baseRaw/scripts/issues_github.json" -OutFile "$WORK_DIR/scripts/issues_github.json"

Set-Location $WORK_DIR
```

---

## Setup completo em um único script

O script `setup-project.ps1` executa os dois passos automaticamente:

1. Importa labels, milestones e issues
2. Configura sprints e sincroniza o Project

### Primeira execução (com criação automática de sprints)

```powershell
& .\scripts\setup-project.ps1 `
  -Owner $GRUPO_OWNER `
  -Repo $GRUPO_REPO `
  -ProjectNumber $PROJECT_NUMBER `
  -ProjectOwner $PROJECT_OWNER `
  -Token $env:GITHUB_TOKEN `
  -AutoCreateIterationField `
  -IterationFieldName "Sprint" `
  -IterationStartDate "2026-04-13" `
  -IterationDuration 14 `
  -IterationCount 5
```

O que acontece:

1. Cria labels e milestones ausentes.
2. Cria issues a partir do JSON, evitando duplicidades.
3. Cria o campo `Iteration` no Project (se não existir).
4. Gera `Sprint 1` a `Sprint 5` com as datas/configuração informadas.
5. Adiciona as issues do repositório ao Project.
6. Atribui a sprint correta a cada issue, conforme o JSON.

### Re-sincronização (quando o JSON mudar)

```powershell
& .\scripts\setup-project.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -ProjectNumber $PROJECT_NUMBER -ProjectOwner $PROJECT_OWNER -Token $env:GITHUB_TOKEN
```

### Teste (dry-run)

Para visualizar o que seria feito sem aplicar mudanças:

```powershell
& .\scripts\setup-project.ps1 `
  -Owner $GRUPO_OWNER `
  -Repo $GRUPO_REPO `
  -ProjectNumber $PROJECT_NUMBER `
  -ProjectOwner $PROJECT_OWNER `
  -Token $env:GITHUB_TOKEN `
  -AutoCreateIterationField `
  -IterationFieldName "Sprint" `
  -IterationStartDate "2026-04-13" `
  -IterationDuration 14 `
  -IterationCount 5 `
  -DryRun
```

---

## Scripts individuais (referência)

Se preferir executar os passos separadamente, use:

- `scripts/import-github-issues.ps1` — importa labels, milestones e issues
- `scripts/sync-project-sprints.ps1` — configura sprints e sincroniza o Project

---

## Windows: quando o PowerShell não é reconhecido

Se aparecer erro como "powershell nao e reconhecido como um comando interno ou externo", use uma destas opcoes:

1. Abra o terminal correto:

- Menu Iniciar -> Windows PowerShell
- ou Windows Terminal com perfil PowerShell

2. Execute pelo caminho completo (funciona mesmo sem PATH):

```cmd
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Get-Host"
```

3. Se voce tiver PowerShell 7 instalado, pode usar:

```cmd
pwsh -NoProfile -Command "Get-Host"
```

Se o script for bloqueado por politica de execucao, rode no PowerShell atual:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Isso vale apenas para a sessao atual.

Exemplo de execucao dos scripts a partir do CMD (sem depender do comando `powershell` no PATH):

```cmd
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\import-github-issues.ps1 -Owner SEU_USUARIO_GITHUB -Repo SEU_REPOSITORIO -Token SEU_TOKEN_AQUI

%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync-project-sprints.ps1 -Owner SEU_USUARIO_GITHUB -Repo SEU_REPOSITORIO -ProjectNumber 1 -ProjectOwner SEU_USUARIO_GITHUB -Token SEU_TOKEN_AQUI
```

---

## Criar view Kanban (manual)

> A API do GitHub Projects v2 não expõe criação de views por script.

Passos no GitHub UI:

1. Abra o Project do grupo
2. Clique em **+ New view** → escolha **Board**
3. Nome: `Kanban`
4. Em **Column by**, escolha **Status**
5. Em **Swimlanes**, escolha **Sprint**
6. Em **Slice by**, opção: **Milestone** (opcional)

Colunas recomendadas (campo `Status`):

- `Backlog`
- `Planejado`
- `Em Progresso`
- `Em Revisão`
- `Concluído`

![Imagem GITHUB Project](./image/TUTORIAL_GITHUB_PROJECTS/1776018798953.png?version%3D1776039825899)

---

## Checklist rápido

- [ ] Token criado com `repo` e `project`
- [ ] Variáveis do grupo preenchidas
- [ ] Escolhido o método: ZIP, Fluxo A ou Fluxo B
- [ ] Script `setup-project.ps1` executado
- [ ] View Kanban criada e colunas ajustadas

---

## Troubleshooting

- **Erro:** `Resource not accessible by personal access token` — Token sem permissão `project`.
- **Mensagem:** `Sem iteracao correspondente para 'Sprint X'` — A sprint não existe no campo Iteration do Project.
- **Issues não aparecem no Project:** Verifique `ProjectNumber`, `ProjectOwner` e permissões do token.
- **Erro:** `'powershell' nao e reconhecido` — abra o Windows PowerShell/Windows Terminal (perfil PowerShell) ou use o executavel completo: `%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe`.
- **Erro:** `running scripts is disabled on this system` — execute `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` e tente novamente na mesma janela.

---

## Segurança

- Não compartilhe tokens em chats, prints ou commits.
- Revogue tokens expostos imediatamente.
- Gere um novo token após concluir a configuração.

---

## Bloco rápido (copiar e colar)

```powershell
$env:GITHUB_TOKEN = "SEU_TOKEN_AQUI"
$GRUPO_OWNER = "SEU_USUARIO_GITHUB"
$GRUPO_REPO = "SEU_REPOSITORIO"
$PROJECT_OWNER = "SEU_USUARIO_GITHUB"
$PROJECT_NUMBER = 1

# Fluxo A: com arquivos no repositorio do grupo
# Set-Location "CAMINHO_LOCAL_DO_REPOSITORIO"

# Fluxo B: sem alterar repositorio do grupo
# $BASE_OWNER = "gitserpro"
# $BASE_REPO = "lapis"
# $BASE_BRANCH = "main"
# $WORK_DIR = Join-Path $env:TEMP "lapis-gh-project-setup"
# New-Item -ItemType Directory -Force -Path "$WORK_DIR/scripts" | Out-Null
# $baseRaw = "https://raw.githubusercontent.com/$BASE_OWNER/$BASE_REPO/$BASE_BRANCH"
# Invoke-WebRequest "$baseRaw/scripts/setup-project.ps1" -OutFile "$WORK_DIR/scripts/setup-project.ps1"
# Invoke-WebRequest "$baseRaw/scripts/issues_github.json" -OutFile "$WORK_DIR/scripts/issues_github.json"
# Set-Location $WORK_DIR

& .\scripts\setup-project.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -ProjectNumber $PROJECT_NUMBER -ProjectOwner $PROJECT_OWNER -Token $env:GITHUB_TOKEN -AutoCreateIterationField -IterationFieldName "Sprint" -IterationStartDate "2026-04-13" -IterationDuration 14 -IterationCount 5
```

---

## Uso em sala (professor)

Sugestão de condução:

1. Compartilhe este repositório como base para a turma.
2. Cada grupo cria seu repositório e Project.
3. Escolham um fluxo:

- Fluxo A: copiam `setup-project.ps1` e `issues_github.json` para a pasta `scripts` do repositório do grupo.
- Fluxo B: baixam os arquivos para pasta temporária local.

4. Executam o comando `setup-project.ps1` com os parâmetros do grupo.
5. Validam com o checklist acima.

Resultados esperados:

1. Repositório do grupo com issues, labels e milestones criadas.
2. Project do grupo com sprints configuradas e issues distribuídas.
3. View Kanban criada com status padronizados.

---

## Próxima aula: Gestão de Configuração (projeto de requisitos)

Objetivo: estruturar controle de versões e mudanças do artefato de requisitos.

### Entregáveis

1. Estratégia de branches (ex.: `main`, `develop`, `feature/*`, `hotfix/*`).
2. Convenção de commits (ex.: Conventional Commits).
3. Política de baseline por marco (M1, M2, M3).
4. Processo de controle de mudanças documentado.
5. Template mínimo de Pull Request.

### Fluxo recomendado

1. Criar branch para alteração de requisito.
2. Atualizar artefatos (issue, SRS, UML, critérios de aceite).
3. Abrir Pull Request com justificativa.
4. Revisar impacto técnico e de negócio.
5. Aprovar e integrar em `develop`.
6. Gerar baseline em `main` com tag (ex.: `v1.0-requisitos`).

### Critérios de qualidade

1. Toda mudança de requisito vinculada a uma issue.
2. Toda issue relevante vinculada a uma milestone.
3. Alterações críticas com análise de impacto registrada.
4. Marcos finalizados com tag de baseline.

### Comandos úteis

```powershell
git checkout -b feature/requisito-123
git add .
git commit -m "feat(requisitos): atualiza criterio de aceite da US-123"
git push -u origin feature/requisito-123
```

# Tutorial: Configuração de Issues, Milestones, Sprints e Kanban por Grupo

> Guia adaptado para uso em turma — cada **grupo** usa o próprio repositório e Project.

## Sumário

- [Pré-requisitos](#pré-requisitos)
- [Variáveis do grupo](#variáveis-do-grupo)
- [Importar labels, milestones e issues](#importar-labels-milestones-e-issues)
- [Configurar sprints e sincronizar Project](#configurar-sprints-e-sincronizar-project)
- [Criar view Kanban (manual)](#criar-view-kanban-manual)
- [Checklist rápido](#checklist-rápido)
- [Troubleshooting](#troubleshooting)
- [Segurança](#segurança)
- [Bloco rápido (copiar e colar)](#bloco-rápido-copiar-e-colar)
- [Uso em sala (professor)](#uso-em-sala-professor)
- [Próxima aula: Gestão de Configuração](#próxima-aula-gestão-de-configuração)

---

## Pré-requisitos

- PowerShell (Windows)
- Token GitHub com permissões: **`repo`** (se for privado) e **`project`**
- O repositório do grupo deve conter:
  - `scripts/import-github-issues.ps1`
  - `scripts/sync-project-sprints.ps1`
  - `Requisitos/Artefatos/issues_github.json`

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

Set-Location "CAMINHO_LOCAL_DO_REPOSITORIO"
```

Exemplo:

```powershell
$GRUPO_OWNER = "grupo-a"
$GRUPO_REPO = "projeto-requisitos-grupo-a"
$PROJECT_OWNER = "joao-silva"
$PROJECT_NUMBER = 2
```

---

## Importar labels, milestones e issues

1. Teste (dry-run):

```powershell
.\scripts\import-github-issues.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -Token $env:GITHUB_TOKEN -DryRun
```

2. Execução real:

```powershell
.\scripts\import-github-issues.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -Token $env:GITHUB_TOKEN
```

O script:

- cria labels ausentes
- cria milestones ausentes
- cria issues a partir do JSON
- evita duplicidade por título

---

## Configurar sprints e sincronizar Project

### Primeira execução (criação automática de sprints)

```powershell
.\scripts\sync-project-sprints.ps1 `
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

1. Cria o campo `Iteration` no Project (se não existir).
2. Gera `Sprint 1` a `Sprint 5` com as datas/configuração informadas.
3. Adiciona as issues do repositório ao Project.
4. Atribui a sprint correta a cada issue, conforme o JSON.

### Re-sincronização (quando o JSON mudar)

```powershell
.\scripts\sync-project-sprints.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -ProjectNumber $PROJECT_NUMBER -ProjectOwner $PROJECT_OWNER -Token $env:GITHUB_TOKEN
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

---

## Checklist rápido

- [ ] Token criado com `repo` e `project`
- [ ] Variáveis do grupo preenchidas
- [ ] Importação de issues executada
- [ ] Sincronização de sprints executada
- [ ] View Kanban criada e colunas ajustadas

---

## Troubleshooting

- **Erro:** `Resource not accessible by personal access token` — Token sem permissão `project`.
- **Mensagem:** `Sem iteracao correspondente para 'Sprint X'` — A sprint não existe no campo Iteration do Project.
- **Issues não aparecem no Project:** Verifique `ProjectNumber`, `ProjectOwner` e permissões do token.

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
Set-Location "CAMINHO_LOCAL_DO_REPOSITORIO"

.\scripts\import-github-issues.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -Token $env:GITHUB_TOKEN

.\scripts\sync-project-sprints.ps1 -Owner $GRUPO_OWNER -Repo $GRUPO_REPO -ProjectNumber $PROJECT_NUMBER -ProjectOwner $PROJECT_OWNER -Token $env:GITHUB_TOKEN -AutoCreateIterationField -IterationFieldName "Sprint" -IterationStartDate "2026-04-13" -IterationDuration 14 -IterationCount 5
```

---

## Uso em sala (professor)

Sugestão de condução:

1. Compartilhe este repositório como base para a turma.
2. Cada grupo cria seu repositório e Project.
3. Copiam os scripts e o JSON para o repositório do grupo.
4. Executam as seções **Variáveis**, **Importar** e **Sincronizar**.
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

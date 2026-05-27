# Especificação de Requisitos Funcionais

# Caso de Uso (CDU) – Cadastrar e Gerenciar Questões do ENADE

---

# Histórico de Versões

| Data       | Versão | Descrição                                                                  | Autor        |
| ---------- | ------- | ---------------------------------------------------------------------------- | ------------ |
| 27/05/2026 | 1.0     | Criação inicial do CDU de cadastro de questões ENADE                      | Prof Marcelo |
| 27/05/2026 | 1.1     | Inclusão de listagem de questões, origem da questão e filtros de consulta | Prof Marcelo |
| 27/05/2026 | 1.2     | Inclusão das especificações das interfaces visuais e regras de negócio   | Prof Marcelo |

---

# 1. Nome do Caso de Uso

**Cadastrar e Gerenciar Questões do ENADE**

---

# 2. Objetivo

Permitir que professores realizem o cadastro, importação, consulta, edição e gerenciamento de questões no padrão ENADE, incluindo:

- Enunciados textuais
- Imagens
- Alternativas de resposta
- Comentários pedagógicos
- Classificação acadêmica
- Controle de situação da questão
- Rastreamento da origem da questão

Também permitir a importação automática de questões a partir de PDFs de provas antigas do ENADE.

---

# 3. Tipo de Caso de Uso

**Concreto**

---

# 4. Atores

## 4.1 Primário

- Professor

---

## 4.2 Secundário

- Coordenador de Curso
- Sistema de Processamento de PDF
- Sistema de OCR
- Sistema de Armazenamento de Arquivos

---

# 5. Precondições

- O professor deve estar autenticado no sistema.
- O professor deve possuir permissão para cadastro e gerenciamento de questões.
- Cursos, disciplinas e competências devem estar previamente cadastrados.

---

# 6. Fluxo Principal

## P1. Acessar funcionalidade de gerenciamento de questões

O professor acessa o módulo de gerenciamento de questões ENADE.

---

## P2. Selecionar opção “Cadastrar Nova Questão”

O professor seleciona a opção para cadastrar uma nova questão.

O sistema inicia o processo de cadastro.

---

## P3. Selecionar forma de cadastro

O sistema apresenta as opções:

- Cadastro manual da questão
- Importação de questões via PDF

### Referência

- Caso o professor escolha importação via PDF, o sistema segue para o Fluxo Alternativo A1.

---

## P4. Informar classificação pedagógica

O professor informa:

- Curso
- Disciplina
- Competência
- Tema/Subtema (opcional)
- Grau de dificuldade (opcional)

---

## P4.1. Informar origem da questão

O professor informa a origem da questão.

O sistema deve permitir selecionar:

- Questão elaborada pelo professor
- Questão baseada em prova oficial do ENADE
- Questão adaptada de outra instituição
- Questão importada de PDF
- Outra origem

---

## P4.2. Informar descrição complementar da origem

O professor pode informar:

- Ano da prova
- Instituição
- Referência bibliográfica
- Observações adicionais

---

## P5. Informar dados da questão

O professor preenche:

- Número da questão (opcional)
- Título da questão (opcional)
- Enunciado textual

---

## P5.1. Inserir imagens no enunciado

O professor pode anexar imagens ao enunciado.

O sistema deve permitir:

- Upload de imagens
- Pré-visualização
- Remoção da imagem antes da gravação

---

## P6. Informar alternativas

O professor cadastra as alternativas da questão.

Cada alternativa deve possuir:

- Identificador (A, B, C, D, E)
- Texto da alternativa
- Imagem associada (opcional)

---

## P7. Definir resposta correta

O professor seleciona apenas uma alternativa correta.

O sistema valida que apenas uma alternativa esteja marcada.

---

## P8. Informar comentário geral da resolução

O professor registra comentário explicando a resolução da questão.

---

## P9. Informar comentários individuais das alternativas

O professor registra comentários específicos para cada alternativa.

Os comentários devem permitir explicar:

- Motivo da alternativa correta
- Motivo do erro das alternativas incorretas

---

## P10. Definir situação da questão

O professor define a situação inicial da questão:

- Rascunho
- Em revisão
- Aprovada
- Publicada

---

## P11. Revisar questão

O sistema apresenta pré-visualização da questão no formato ENADE.

---

## P12. Confirmar gravação

O professor confirma o cadastro.

### Referências

- Caso o professor escolha salvar parcialmente, o sistema segue para o Fluxo Alternativo A2.
- Caso o professor esteja editando uma questão existente, o sistema segue para o Fluxo Alternativo A3.

---

## P13. Persistir informações

O sistema grava:

- Dados da questão
- Alternativas
- Comentários
- Situação
- Classificação pedagógica
- Origem da questão
- Imagens associadas

---

## P14. Exibir confirmação

O sistema apresenta mensagem de sucesso no cadastro da questão.

---

# 7. Fluxos Alternativos

## A1. Importar prova ENADE via PDF

### A1.1. Selecionar importação por PDF

O professor escolhe a opção de importação.

---

### A1.2. Realizar upload do PDF

O professor seleciona o arquivo PDF.

---

### A1.3. Processar PDF

O sistema realiza:

- Extração textual
- OCR
- Identificação das questões
- Identificação das alternativas
- Identificação de imagens

---

### A1.4. Exibir questões detectadas

O sistema apresenta as questões extraídas para validação.

---

### A1.5. Revisar informações importadas

O professor revisa e corrige:

- Enunciados
- Alternativas
- Imagens
- Estrutura das questões

---

### A1.6. Complementar comentários pedagógicos

O professor informa:

- Comentário geral
- Comentários por alternativa
- Competência
- Situação

---

### A1.7. Confirmar importação

O professor confirma a importação.

---

### A1.8. Gravar questões importadas

O sistema grava as questões validadas.

---

## A2. Salvar rascunho

### A2.1. Solicitar salvamento parcial

O professor escolhe salvar a questão como rascunho.

---

### A2.2. Persistir rascunho

O sistema grava parcialmente os dados preenchidos.

---

### A2.3. Confirmar salvamento

O sistema informa sucesso na gravação do rascunho.

---

## A3. Editar questão cadastrada

### A3.1. Selecionar questão

O professor localiza uma questão existente.

---

### A3.2. Alterar informações

O professor modifica os dados necessários.

---

### A3.3. Confirmar atualização

O sistema grava as alterações.

---

## A4. Consultar questões cadastradas

### A4.1. Acessar consulta de questões

O professor seleciona a opção “Consultar Questões” no módulo de gerenciamento de questões.

---

### A4.2. Informar filtros

O sistema permite pesquisar por:

- Texto do enunciado
- Curso
- Disciplina
- Competência
- Situação
- Origem
- Professor responsável
- Data de cadastro

---

### A4.3. Selecionar situação

O sistema permite filtrar por:

- Rascunho
- Em revisão
- Aprovada
- Reprovada
- Publicada
- Arquivada

---

### A4.4. Executar pesquisa

O professor solicita a pesquisa.

---

### A4.5. Exibir resultados

O sistema apresenta listagem contendo:

- Código da questão
- Resumo do enunciado
- Curso
- Disciplina
- Competência
- Origem
- Autor
- Situação
- Data de cadastro

---

### A4.6. Selecionar ação sobre a questão

O professor pode:

- Visualizar
- Editar
- Duplicar
- Excluir
- Alterar situação
- Exportar

---

### A4.7. Navegar entre páginas

O sistema permite paginação dos resultados.

---

# 8. Fluxos de Exceção

## E1. Arquivo PDF inválido

### E1.1. Validar arquivo

O sistema verifica se o arquivo é um PDF válido.

---

### E1.2. Exibir erro

O sistema informa que o arquivo é inválido ou está corrompido.

---

## E2. Falha na extração automática

### E2.1. Detectar inconsistência

O sistema identifica falhas na leitura do PDF.

---

### E2.2. Informar problema

O sistema apresenta mensagem de inconsistência.

---

### E2.3. Permitir correção manual

O sistema libera edição manual.

---

## E3. Questão sem alternativa correta

### E3.1. Validar alternativas

O sistema verifica se existe resposta correta definida.

---

### E3.2. Informar erro

O sistema informa obrigatoriedade da alternativa correta.

---

## E4. Mais de uma alternativa correta

### E4.1. Validar respostas

O sistema identifica múltiplas respostas corretas.

---

### E4.2. Informar inconsistência

O sistema informa que apenas uma alternativa pode ser correta.

---

## E5. Campos obrigatórios não preenchidos

### E5.1. Validar formulário

O sistema valida os campos obrigatórios.

---

### E5.2. Destacar pendências

O sistema destaca os campos não preenchidos.

---

# 9. Pós-condições

- A questão fica disponível para reutilização em provas e simulados.
- As imagens ficam armazenadas no sistema.
- As classificações pedagógicas ficam disponíveis para relatórios.
- O histórico da origem da questão fica registrado.
- As questões ficam disponíveis para pesquisa e reutilização institucional.

---

# 10. Requisitos Não Funcionais

- O sistema deve suportar imagens JPG, PNG e WEBP.
- O sistema deve suportar upload de PDFs de até 50MB.
- O processamento do PDF deve ocorrer em até 2 minutos para arquivos com até 100 questões.
- O sistema deve permitir OCR para PDFs digitalizados.
- O sistema deve permitir edição rica de texto.
- O sistema deve possuir interface responsiva.
- O sistema deve registrar auditoria das alterações.
- O sistema deve permitir pesquisa textual rápida.
- A listagem deve retornar resultados em até 5 segundos para bases com até 100 mil questões.
- O sistema deve permitir paginação e ordenação dos resultados.

---

# 11. Ponto de Extensão

## PE1. Gerenciar Competências

Permite manutenção das competências.

---

## PE2. Gerenciar Disciplinas

Permite manutenção das disciplinas.

---

## PE3. Gerar Simulados

Permite utilização das questões em simulados.

---

## PE4. Exportar Questões

Permite exportar questões para outros formatos.

---

# 12. Frequência de Utilização

**Alta**

As funcionalidades mais utilizadas serão:

- Cadastro manual
- Importação de PDFs
- Consulta de questões
- Revisão pedagógica
- Pesquisa textual

---

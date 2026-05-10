# Especificação de Requisitos Funcionais

## Caso de Uso (CDU) - F1.1 Cadastro de Feirante

## Histórico de Versões

<!-- markdownlint-disable MD060 -->
| Data       | Versão | Descrição                                                           | Autor        |
| ---------- | ------ | ------------------------------------------------------------------- | ------------ |
| 09/05/2026 | 1.0    | Criação do exemplo de CDU para a funcionalidade F1.1               | Equipe Lapis |
| 10/05/2026 | 1.1    | Inclusão de referências explícitas às regras de negócio (RN1-RN6)  | Equipe Lapis |
<!-- markdownlint-enable MD060 -->

## 1. Nome do Caso de Uso

Cadastrar Feirante

## 2. Objetivo

Permitir que a Secretaria Municipal cadastre um novo feirante no sistema, registrando seus dados principais para habilitar a participação nas feiras e os processos de fiscalização, cobrança e emissão de licença.

## 3. Tipo de Caso de Uso

Concreto.

## 4. Atores

### 4.1 Primário

- Secretaria Municipal (atendente ou servidor responsável pelo cadastro).

### 4.2 Secundário

- Feirante (fornece os dados).
- Sistema de autenticação (valida perfil de acesso).

## 5. Precondições

- Usuário da Secretaria Municipal autenticado no sistema.
- Usuário com permissão para cadastrar feirantes.
- Sistema e base de dados disponíveis.

## 6. Fluxo Principal

### P1. Iniciar cadastro de feirante

1. P1.1 - O ator primário acessa o menu de cadastro de feirantes.
2. P1.2 - O sistema exibe o formulário de cadastro com os campos obrigatórios.
3. P1.3 - O ator primário informa os dados do feirante (nome, CPF, telefone e tipo de produto comercializado).
4. P1.4 - O ator primário confirma a operação de cadastro.
5. P1.5 - O sistema valida os campos obrigatórios e o formato dos dados informados, conforme [RN1](exemplo-rn-cadastro-licenca-feirante.md#rn1-cadastro-de-feirante-exige-dados-minimos-validos).
6. P1.6 - O sistema verifica se já existe cadastro ativo para o CPF informado, conforme [RN2](exemplo-rn-cadastro-licenca-feirante.md#rn2-cpf-de-feirante-deve-ser-unico).
7. P1.7 - Não havendo duplicidade, o sistema grava o novo cadastro de feirante.
8. P1.8 - O sistema registra a operação no histórico de alterações, conforme [RN6](exemplo-rn-cadastro-licenca-feirante.md#rn6-operacoes-criticas-devem-ser-auditadas).
9. P1.9 - O sistema apresenta mensagem de sucesso e disponibiliza o código de identificação do feirante cadastrado.

## 7. Fluxos Alternativos

### A1. Feirante já cadastrado no sistema

1. A1.1 - No passo P1.6, o sistema identifica cadastro já existente para o CPF informado.
2. A1.2 - O sistema exibe os dados já cadastrados e oferece opção de abrir o caso de uso F1.2 Atualização e remoção de cadastro.
3. A1.3 - O ator primário opta por consultar ou atualizar o cadastro existente.

### A2. Cadastro salvo com licença pendente

1. A2.1 - Após o passo P1.9, o sistema indica que o feirante está cadastrado, porém com licença pendente, conforme [RN3](exemplo-rn-cadastro-licenca-feirante.md#rn3-status-inicial-do-cadastro-deve-indicar-licenca-pendente).
2. A2.2 - O sistema oferece atalho para o processo de emissão de licença.

## 8. Fluxos de Exceção

### E1. CPF inválido

1. E1.1 - No passo P1.5, o sistema identifica CPF em formato inválido, conforme [RN1](exemplo-rn-cadastro-licenca-feirante.md#rn1-cadastro-de-feirante-exige-dados-minimos-validos).
2. E1.2 - O sistema bloqueia o salvamento, destaca o campo com erro e exibe mensagem orientando correção.
3. E1.3 - O fluxo retorna ao passo P1.3.

### E2. Falha ao persistir dados

1. E2.1 - No passo P1.7, ocorre falha técnica na gravação do cadastro.
2. E2.2 - O sistema não conclui o cadastro e exibe mensagem de indisponibilidade temporária.
3. E2.3 - O sistema registra log técnico da falha para diagnóstico.

## 9. Pós-condições

- Cadastro de feirante criado com status ativo ou pendente de licença.
- Histórico de auditoria atualizado com usuário, data e operação realizada.
- Dados disponíveis para os demais processos do sistema (fiscalização, taxas e relatórios).

## 10. Requisitos Não Funcionais

- A validação e confirmação do cadastro devem ocorrer em até 3 segundos na maior parte das operações.
- O sistema deve registrar trilha de auditoria de inclusão de cadastro.
- O acesso à função deve respeitar controle de perfil e autenticação.
- Dados pessoais do feirante devem ser protegidos contra acesso não autorizado.

## 11. Ponto de Extensão

### PE1. Emissão de licença

Após o cadastro concluído, o fluxo pode ser estendido para emissão de licença do feirante, conforme regra administrativa vigente, por meio do CDU F1.3 Emissão de Licença do Feirante.

## 12. Frequência de Utilização

Alta, especialmente em períodos de abertura de novas feiras, regularização cadastral e recadastramento anual.

## 13. Interface Visual

### IV1. Formulário de cadastro de feirante

Tela com campos de identificação do feirante, validação de preenchimento obrigatório, botões de confirmar e cancelar, e mensagens de retorno da operação.

<!-- markdownlint-disable MD060 -->
| Campo | Obrigatório | Formato | Regras de validação |
| --- | --- | --- | --- |
| Nome completo | Sim | Texto livre (2 a 120 caracteres) | Não permitir somente números ou caracteres especiais; remover espaços duplicados. |
| CPF | Sim | `999.999.999-99` ou 11 dígitos | Validar dígitos verificadores; impedir CPF já cadastrado (regra de duplicidade). |
| Telefone | Sim | `(99) 99999-9999` ou 10/11 dígitos | Aceitar DDD válido; normalizar para formato padrão no salvamento. |
| Tipo de produto comercializado | Sim | Lista de seleção | Permitir apenas valores do catálogo de categorias definido pela secretaria. |
| Observações | Não | Texto livre (até 500 caracteres) | Campo opcional; bloquear conteúdo malicioso (scripts/HTML). |
| Código do feirante | Não (gerado pelo sistema) | Alfanumérico | Gerado automaticamente após cadastro concluído. |
| Status da licença | Não (informativo) | Valor fixo inicial | Exibir como "Pendente de licença" após cadastro bem-sucedido. |
<!-- markdownlint-enable MD060 -->

## 14. Observações

- Este CDU é um exemplo didático e pode ser adaptado para regras específicas de cada município.
- Campos adicionais (endereço, categoria de produto, documentos) podem ser exigidos conforme legislação local.

## 15. Referências

- [Visão da demanda - sistema de feira livre](exemplo-feira-livre-visao.md)
- [Glossário - feira livre](glossario-feira-livre.md)
- [Exemplo de requisitos não funcionais](exemplo-requisitos-nao-funcionais-feira-livre.md)
- [Exemplo de regras de negócio - cadastro e licença de feirante](exemplo-rn-cadastro-licenca-feirante.md)
- [CDU F1.3 Emissão de licença do feirante](exemplo-cdu-f1-3-emissao-licenca-feirante.md)

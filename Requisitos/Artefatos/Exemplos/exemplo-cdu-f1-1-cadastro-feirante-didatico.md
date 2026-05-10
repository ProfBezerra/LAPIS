# Exemplo Didático de Caso de Uso

> **Tema:** Sistema de Gestão das Feiras Livres de Fortaleza  
> **Caso de uso:** F1.1 Cadastro de Feirante  
> **Objetivo:** ensinar, de forma simples, como estruturar um caso de uso completo.

## 1. O que este exemplo ensina?

Este documento mostra como descrever um caso de uso em linguagem clara, com foco em comportamento do sistema.

Você verá:

- quem inicia a ação (ator primário);
- quais condições precisam existir antes do fluxo (precondições);
- o caminho principal de sucesso (fluxo principal);
- desvios esperados (fluxos alternativos);
- erros e tratamento de falhas (fluxos de exceção);
- resultado final da operação (pós-condições).

## 2. Histórico de Versões

<!-- markdownlint-disable MD060 -->
| Data       | Versão | Descrição                                                     | Autor        |
| ---------- | ------ | ------------------------------------------------------------- | ------------ |
| 09/05/2026 | 1.0    | Criação do exemplo didático de CDU para cadastro de feirante | Equipe Lapis |
| 09/05/2026 | 1.1    | Inclusão da seção IV1 com tabela de campos e validações      | Equipe Lapis |
<!-- markdownlint-enable MD060 -->

## 3. Identificação do Caso de Uso

### 3.1 Nome

Cadastrar Feirante

### 3.2 Objetivo

Permitir que a Secretaria Municipal registre um novo feirante no sistema para que ele possa participar das feiras de forma regularizada.

### 3.3 Tipo

Concreto.

## 4. Atores

### 4.1 Primário

- Secretaria Municipal.

### 4.2 Secundários

- Feirante (fornece dados para cadastro).
- Sistema de autenticação (garante que apenas usuários autorizados acessem a função).

## 5. Precondições

- Usuário autenticado no sistema.
- Perfil com permissão para cadastrar feirantes.
- Sistema e banco de dados disponíveis.

## 6. Fluxo Principal (cenário de sucesso)

1. O usuário da Secretaria abre a funcionalidade de cadastro de feirante.
2. O sistema exibe o formulário com campos obrigatórios.
3. O usuário informa nome, CPF, telefone e tipo de produto comercializado.
4. O usuário confirma o cadastro.
5. O sistema valida os dados preenchidos.
6. O sistema verifica se já existe CPF cadastrado.
7. Não havendo duplicidade, o sistema salva o novo cadastro.
8. O sistema registra a operação no histórico de alterações.
9. O sistema exibe mensagem de sucesso.

## 7. Fluxos Alternativos

### A1. CPF já cadastrado

1. No momento da validação, o sistema identifica CPF já existente.
2. O sistema não cria novo cadastro.
3. O sistema mostra os dados existentes e oferece opção de atualização do cadastro.

### A2. Cadastro concluído com licença pendente

1. Após salvar o cadastro, o sistema informa que a licença ainda está pendente.
2. O sistema oferece atalho para o processo de emissão de licença.

## 8. Fluxos de Exceção

### E1. CPF inválido

1. O sistema detecta CPF em formato inválido.
2. O sistema bloqueia a conclusão do cadastro.
3. O sistema orienta a correção do campo antes de continuar.

### E2. Falha de persistência

1. Ocorre falha técnica ao salvar dados no banco.
2. O sistema informa indisponibilidade temporária.
3. O sistema registra log técnico para suporte.

## 9. Pós-condições

- Cadastro criado (ativo ou pendente de licença).
- Operação registrada em histórico.
- Dados disponíveis para fiscalização, taxas e relatórios.

## 10. Dica didática: como melhorar a escrita do CDU

Compare os exemplos:

- Frase vaga: o sistema cadastra o feirante.
- Frase melhor: o sistema valida os dados e salva o cadastro apenas se não houver CPF duplicado.

A segunda frase é melhor porque descreve comportamento observável e regra de negócio.

## 11. Exercícios para sala de aula

1. Escreva um fluxo alternativo para o caso em que o telefone informado está fora do padrão.
2. Crie um fluxo de exceção para indisponibilidade do serviço de autenticação.
3. Defina uma pós-condição adicional para integração com emissão de licença.
4. Reescreva o passo 5 do fluxo principal com mais detalhe técnico e mantendo clareza.

## 12. Interface Visual (IV1)

### IV1. Formulário de cadastro de feirante

Nesta tela, o usuário informa os dados básicos do feirante. A tabela abaixo ajuda a transformar o protótipo em regra verificável.

<!-- markdownlint-disable MD060 -->
| Campo | Obrigatório | Formato | Regra didática de validação |
| --- | --- | --- | --- |
| Nome completo | Sim | Texto (2 a 120 caracteres) | Não aceitar campo vazio e evitar nomes com apenas números. |
| CPF | Sim | `999.999.999-99` ou 11 dígitos | Validar formato e dígitos verificadores; bloquear duplicidade. |
| Telefone | Sim | `(99) 99999-9999` | Validar DDD e quantidade de dígitos. |
| Tipo de produto | Sim | Lista de seleção | Permitir somente opções previstas no catálogo da secretaria. |
| Observações | Não | Texto livre (até 500 caracteres) | Campo opcional; se preenchido, limitar tamanho e sanitizar conteúdo. |
| Código do feirante | Não (automático) | Alfanumérico | Gerado pelo sistema após salvar cadastro com sucesso. |
| Status da licença | Não (informativo) | Texto curto | Exibir valor inicial como "Pendente de licença". |
<!-- markdownlint-enable MD060 -->

## 13. Dica didática: como usar esta tabela em aula

1. Peça para a turma transformar cada linha da tabela em um teste funcional.
2. Compare o que é validação de campo com o que é regra de negócio.
3. Discuta quais campos são de entrada do usuário e quais são gerados pelo sistema.

## 14. Referências

- [CDU exemplo completo F1.1](exemplo-cdu-f1-1-cadastro-feirante.md)
- [Visão da demanda - feira livre](exemplo-feira-livre-visao.md)
- [Glossário - feira livre](glossario-feira-livre.md)
- [Exemplo de RNF - feira livre](exemplo-requisitos-nao-funcionais-feira-livre.md)

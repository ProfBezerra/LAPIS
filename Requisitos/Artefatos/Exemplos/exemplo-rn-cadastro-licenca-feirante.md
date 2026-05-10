# Especificação de Regras de Negócio

## Contexto

Este documento apresenta regras de negócio para os casos de uso:

* F1.1 Cadastro de Feirante
* F1.3 Emissão de Licença do Feirante

## Histórico de Versões

<!-- markdownlint-disable MD060 -->
| Data       | Versão | Descrição                                                  | Autor        |
| ---------- | ------ | ---------------------------------------------------------- | ------------ |
| 10/05/2026 | 1.0    | Criação do exemplo de regras de negócio para F1.1 e F1.3 | Equipe Lapis |
| 10/05/2026 | 1.1    | Padronização de títulos para âncoras e navegação por links | Equipe Lapis |
<!-- markdownlint-enable MD060 -->

## Regras de Negócio

### RN1. Cadastro de feirante exige dados minimos validos

* Identificador: RN1
* Regra: O cadastro de feirante somente pode ser concluído quando os campos obrigatórios (nome, CPF, telefone e tipo de produto) estiverem preenchidos e válidos.
* Critério verificável: O sistema deve impedir o avanço quando houver campo obrigatório ausente ou em formato inválido.

### RN2. CPF de feirante deve ser único

* Identificador: RN2
* Regra: Não pode existir mais de um cadastro ativo de feirante com o mesmo CPF.
* Critério verificável: Ao detectar CPF já cadastrado como ativo, o sistema bloqueia novo cadastro e orienta atualização do registro existente.

### RN3. Status inicial do cadastro deve indicar licença pendente

* Identificador: RN3
* Regra: Após cadastro concluído sem emissão imediata da licença, o feirante deve permanecer com status "Pendente de licença".
* Critério verificável: O status inicial deve ser exibido e persistido como "Pendente de licença" até conclusão de F1.3.

### RN4. Emissao de licenca exige cadastro e documentacao regular

* Identificador: RN4
* Regra: A licença somente pode ser emitida para feirante cadastrado e com documentação obrigatória completa.
* Critério verificável: Se houver pendência documental, o sistema deve bloquear a emissão e exibir as pendências.

### RN5. Vigencia da licenca deve respeitar regra temporal

* Identificador: RN5
* Regra: A data de validade da licença deve ser posterior a data de início e respeitar o prazo máximo permitido para o tipo de licença.
* Critério verificável: O sistema deve impedir gravação quando a validade for menor/igual a data de início ou fora do prazo normativo.

### RN6. Operacoes criticas devem ser auditadas

* Identificador: RN6
* Regra: As operações de cadastro e emissão de licença devem registrar trilha de auditoria com usuário, data/hora e ação executada.
* Critério verificável: Toda inclusão/alteração relevante nesses processos deve gerar registro de auditoria consultável.

## Mapeamento para Casos de Uso

* F1.1 Cadastro de Feirante: RN1, RN2, RN3 e RN6.
* F1.3 Emissão de Licença do Feirante: RN4, RN5 e RN6.

## Referências

* [CDU F1.1 Cadastro de feirante](exemplo-cdu-f1-1-cadastro-feirante.md)
* [CDU F1.3 Emissão de licença do feirante](exemplo-cdu-f1-3-emissao-licenca-feirante.md)
* [Glossário - feira livre](glossario-feira-livre.md)

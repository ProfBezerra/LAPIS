# Especificação de Requisitos Funcionais

## Caso de Uso (CDU) - F1.3 Emissão de Licença do Feirante

## Histórico de Versões

<!-- markdownlint-disable MD060 -->
| Data       | Versão | Descrição                                                                    | Autor        |
| ---------- | ------ | ---------------------------------------------------------------------------- | ------------ |
| 09/05/2026 | 1.0    | Criação do exemplo de CDU para emissão de licença como extensão do F1.1     | Equipe Lapis |
| 09/05/2026 | 1.1    | Detalhamento da IV1 com tabela de campos, formatos e validações             | Equipe Lapis |
| 10/05/2026 | 1.2    | Inclusão de referências explícitas às regras de negócio (RN4-RN6)           | Equipe Lapis |
<!-- markdownlint-enable MD060 -->

## 1. Nome do Caso de Uso

Emitir Licença do Feirante

## 2. Objetivo

Permitir que a Secretaria Municipal emita a licença de atuação do feirante, após o cadastro, validando requisitos administrativos e registrando o período de vigência.

## 3. Tipo de Caso de Uso

Concreto (caso de uso de extensão do F1.1 Cadastro de Feirante).

## 4. Atores

### 4.1 Primário

- Secretaria Municipal (servidor responsável pela emissão de licença).

### 4.2 Secundário

- Feirante (beneficiário da licença).
- Sistema de autenticação (valida permissão de emissão).

## 5. Precondições

- Feirante previamente cadastrado no sistema (F1.1 concluído).
- Fluxo acionado após o ponto de extensão "PE1. Emissão de licença" do CDU F1.1 Cadastro de Feirante.
- Usuário da Secretaria autenticado e com perfil autorizado para emitir licença.
- Documentação mínima exigida cadastrada no sistema.
- Regras de calendário e regularidade da feira disponíveis.

## 6. Fluxo Principal

### P1. Emitir licença

1. P1.1 - O ator primário acessa a funcionalidade de emissão de licença a partir do cadastro do feirante.
2. P1.2 - O sistema exibe dados cadastrais do feirante e o status de regularidade.
3. P1.3 - O ator primário informa os dados da licença (tipo, data de início, data de validade e observações).
4. P1.4 - O ator primário confirma a emissão.
5. P1.5 - O sistema valida regras de negócio e consistência dos dados, conforme [RN4](exemplo-rn-cadastro-licenca-feirante.md#rn4-emissao-de-licenca-exige-cadastro-e-documentacao-regular) e [RN5](exemplo-rn-cadastro-licenca-feirante.md#rn5-vigencia-da-licenca-deve-respeitar-regra-temporal).
6. P1.6 - O sistema gera o número da licença e grava o registro.
7. P1.7 - O sistema atualiza o status do feirante para "Licenciado".
8. P1.8 - O sistema registra a operação no histórico de alterações, conforme [RN6](exemplo-rn-cadastro-licenca-feirante.md#rn6-operacoes-criticas-devem-ser-auditadas).
9. P1.9 - O sistema apresenta mensagem de sucesso e disponibiliza comprovante da licença.

## 7. Fluxos Alternativos

### A1. Licença emitida em momento posterior ao cadastro

1. A1.1 - O ator primário abre o cadastro de feirante em situação "Pendente de licença".
2. A1.2 - O sistema permite iniciar a emissão sem repetir o cadastro.
3. A1.3 - O fluxo segue para P1.3.

### A2. Emissão com validade reduzida

1. A2.1 - Durante P1.3, o ator primário define validade reduzida por regra administrativa.
2. A2.2 - O sistema registra motivo e mantém trilha de auditoria.
3. A2.3 - O fluxo segue para P1.4.

## 8. Fluxos de Exceção

### E1. Feirante com documentação incompleta

1. E1.1 - Em P1.5, o sistema identifica ausência de documentação obrigatória, conforme [RN4](exemplo-rn-cadastro-licenca-feirante.md#rn4-emissao-de-licenca-exige-cadastro-e-documentacao-regular).
2. E1.2 - O sistema bloqueia a emissão da licença.
3. E1.3 - O sistema exibe pendências e orienta regularização.

### E2. Perfil sem permissão

1. E2.1 - Em P1.1, o sistema identifica usuário sem privilégio para emissão.
2. E2.2 - O sistema nega acesso à operação e registra tentativa.

### E3. Falha na gravação da licença

1. E3.1 - Em P1.6, ocorre falha técnica de persistência.
2. E3.2 - O sistema não conclui a emissão e informa indisponibilidade temporária.
3. E3.3 - O sistema grava log técnico para suporte.

## 9. Pós-condições

- Licença emitida e vinculada ao cadastro do feirante.
- Status cadastral atualizado para "Licenciado" quando emissão concluída.
- Registro de auditoria atualizado com usuário, data e operação.

## 10. Requisitos Não Funcionais

- A emissão deve ser concluída em até 3 segundos na maior parte das operações.
- A operação deve registrar auditoria com usuário, data/hora e dados da licença.
- A função deve estar protegida por autenticação e autorização por perfil.
- O comprovante de licença deve estar disponível para consulta e impressão.

## 11. Ponto de Extensão

Não se aplica.

## 12. Frequência de Utilização

Média a alta, com maior incidência em períodos de regularização e abertura de novas feiras.

## 13. Interface Visual

### IV1. Tela de emissão de licença

Tela com dados do feirante, campos de vigência, situação documental e botão de emissão com confirmação.

<!-- markdownlint-disable MD060 -->
| Campo | Obrigatório | Formato | Regras de validação |
| --- | --- | --- | --- |
| Nome do feirante | Não (somente leitura) | Texto | Carregado automaticamente do cadastro F1.1; não editável nesta tela. |
| CPF | Não (somente leitura) | `999.999.999-99` | Exibir CPF do cadastro para conferência; bloquear edição. |
| Número da licença | Não (gerado pelo sistema) | Alfanumérico | Gerado automaticamente na confirmação da emissão. |
| Tipo de licença | Sim | Lista de seleção | Permitir apenas tipos previstos em norma municipal (ex.: provisória, anual). |
| Data de início da vigência | Sim | `dd/mm/aaaa` | Não permitir data inválida; não permitir data anterior ao limite normativo definido. |
| Data de validade | Sim | `dd/mm/aaaa` | Deve ser posterior à data de início; aplicar regras de prazo máximo por tipo de licença. |
| Situação documental | Não (informativo) | Indicador textual | Exibir "Regular" ou pendências; bloquear emissão se documentação obrigatória estiver incompleta. |
| Observações da emissão | Não | Texto livre (até 500 caracteres) | Campo opcional; se preenchido, registrar no histórico e sanitizar conteúdo. |
| Usuário emissor | Não (automático) | Identificador de usuário | Preenchido automaticamente com usuário autenticado para trilha de auditoria. |
| Data/hora da emissão | Não (automático) | `dd/mm/aaaa hh:mm` | Registrada automaticamente na confirmação para auditoria. |
| Botão "Emitir licença" | Sim (ação) | Comando | Habilitar apenas quando validações obrigatórias forem atendidas. |
<!-- markdownlint-enable MD060 -->

## 14. Observações

- A lista de documentos obrigatórios pode variar conforme norma municipal.
- Este exemplo pode ser adaptado para renovação, suspensão ou cancelamento de licença.

## 15. Referências

- [CDU F1.1 Cadastro de feirante](exemplo-cdu-f1-1-cadastro-feirante.md)
- [Exemplo de regras de negócio - cadastro e licença de feirante](exemplo-rn-cadastro-licenca-feirante.md)
- [Visão da demanda - sistema de feira livre](exemplo-feira-livre-visao.md)
- [Glossário - feira livre](glossario-feira-livre.md)

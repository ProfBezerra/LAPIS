# Especificação de Requisitos Funcionais

## Caso de Uso (CDU) - LAPIS

---

## Histórico de Versões

| Data       | Versão | Descrição                                                                  | Autor             |
|------------|---------|----------------------------------------------------------------------------|-------------------|
| 25/05/2026 | 1.0     | Criação do caso de uso de retirada de projetor patrimonial                 | Marcelo Alcantara |
| 26/05/2026 | 1.1     | Inclusão do controle de sala/local de utilização do projetor               | Marcelo Alcantara |

---

# 1. Nome do Caso de Uso

**Retirar Projetor Patrimonial**

---

# 2. Objetivo

Permitir que o professor realize autonomamente a retirada de projetores e acessórios, registrando eletronicamente a movimentação patrimonial do equipamento através de leitura de QR Code ou aproximação (NFC/RFID), com aceite digital do termo de responsabilidade e identificação da sala/local de utilização.

---

# 3. Tipo de Caso de Uso

| Item | Valor |
|---|---|
| Tipo do Caso de Uso | Concreto |

---

# 4. Atores

## 4.1 Primário

| Ator | Descrição |
|---|---|
| Professor | Realiza a retirada do projetor e confirma eletronicamente o termo de responsabilidade |

---

## 4.2 Secundário

| Ator | Descrição |
|---|---|
| Sistema Patrimonial | Responsável pela consulta e atualização dos dados patrimoniais |
| Sistema de Autenticação Institucional | Responsável pela autenticação do professor |

---

# 5. Precondições

| Código | Descrição |
|---|---|
| PRE01 | O professor deve estar autenticado no sistema |
| PRE02 | O equipamento deve estar cadastrado no patrimônio |
| PRE03 | O projetor deve possuir status “Disponível” |
| PRE04 | O equipamento deve possuir QR Code ou NFC/RFID |
| PRE05 | O professor deve possuir permissão para retirada de equipamentos |

---

# 6. Fluxo Principal

## P1. Acessar funcionalidade de retirada

### P1.1.
O professor acessa a funcionalidade de retirada de equipamentos.

---

## P2. Identificar equipamento

### P2.1.
O professor realiza a leitura do QR Code do projetor.

### P2.2.
Alternativamente, o professor aproxima o equipamento do leitor NFC/RFID.

### P2.3.
O sistema identifica o equipamento patrimonial.

### P2.4.
O sistema apresenta:
- Número patrimonial;
- Modelo do equipamento;
- Situação;
- Disponibilidade.

---

## P3. Informar local de utilização

### P3.1.
O professor informa a sala ou local onde o projetor será utilizado.

### P3.2.
O sistema apresenta:
- blocos;
- salas;
- laboratórios;
- auditórios;
- opção de local manual.

### P3.3.
O professor seleciona o local de utilização.

### P3.4.
O sistema vincula o local à movimentação patrimonial.

---

## P4. Informar acessórios

### P4.1.
O professor informa os acessórios retirados juntamente com o projetor.

### P4.2.
O sistema apresenta a lista de acessórios disponíveis.

### P4.3.
O professor seleciona os acessórios desejados.

---

## P5. Confirmar retirada

### P5.1.
O sistema apresenta o termo de responsabilidade.

### P5.2.
O professor realiza o aceite eletrônico do termo.

### P5.3.
O sistema registra:
- Professor responsável;
- Equipamento retirado;
- Sala/local de utilização;
- Acessórios vinculados;
- Data e hora da retirada.

---

## P6. Finalizar operação

### P6.1.
O sistema altera o status do equipamento para “Em Uso”.

### P6.2.
O sistema conclui a operação.

### P6.3.
O sistema gera comprovante eletrônico de retirada.

---

# 7. Fluxos Alternativos

## A1. Equipamento indisponível

### A1.1.
O sistema identifica que o equipamento está indisponível.

### A1.2.
O sistema exibe mensagem de indisponibilidade.

### A1.3.
O professor pode selecionar outro equipamento.

### A1.4.
O fluxo retorna ao passo P2.

---

## A2. Falha na leitura do QR Code

### A2.1.
O sistema não consegue identificar o QR Code ou NFC/RFID.

### A2.2.
O professor realiza busca manual pelo patrimônio.

### A2.3.
O fluxo retorna ao passo P2.3.

---

## A3. Cancelamento da operação

### A3.1.
O professor cancela a retirada antes da confirmação.

### A3.2.
O sistema encerra o fluxo sem registrar movimentação patrimonial.

---

# 8. Fluxos de Exceção

## E1. Professor não autorizado

### E1.1.
O sistema identifica ausência de permissão de retirada.

### E1.2.
O sistema exibe mensagem de impedimento.

### E1.3.
O caso de uso é encerrado.

---

## E2. Falha de comunicação com sistema patrimonial

### E2.1.
O sistema não consegue consultar os dados patrimoniais.

### E2.2.
O sistema exibe mensagem de indisponibilidade temporária.

### E2.3.
O caso de uso é interrompido.

---

## E3. Equipamento sem patrimônio válido

### E3.1.
O sistema identifica patrimônio inválido ou inexistente.

### E3.2.
O sistema bloqueia a retirada.

### E3.3.
O sistema orienta o professor a procurar suporte administrativo.

---

# 9. Pós-condições

| Código | Descrição |
|---|---|
| POS01 | O equipamento fica vinculado ao professor responsável |
| POS02 | O status do equipamento passa para “Em Uso” |
| POS03 | O histórico patrimonial é atualizado |
| POS04 | O termo eletrônico fica armazenado no sistema |
| POS05 | O local de utilização do equipamento fica registrado |

---

# 10. Requisitos Não Funcionais

| Código | Requisito |
|---|---|
| RNF01 | O sistema deve responder à leitura QR Code/NFC em até 3 segundos |
| RNF02 | O sistema deve registrar data e hora com precisão mínima de segundos |
| RNF03 | O sistema deve manter rastreabilidade das movimentações |
| RNF04 | O sistema deve funcionar em desktop, tablet e totem |
| RNF05 | O termo eletrônico deve ser armazenado por no mínimo 5 anos |
| RNF06 | O sistema deve integrar autenticação institucional segura |
| RNF07 | Toda retirada deve possuir local de utilização informado |
| RNF08 | O sistema deve permitir rastrear equipamentos por sala |

---

# 11. Ponto de Extensão

## PE1. Devolver Projetor Patrimonial

Permite registrar a devolução do equipamento previamente retirado.

---

# 12. Frequência de Utilização

| Item | Informação |
|---|---|
| Frequência | Alta |
| Perfil de Uso | Utilização diária por professores |
| Informações mais acessadas | Patrimônio, disponibilidade, sala e acessórios |

---

# 13. Interface Visual

## IV1. Tela de Retirada de Equipamentos

### Leiaute da Tela

Tela utilizada pelo professor para realizar a retirada do equipamento em autoatendimento.

---

## 13.1 Campos da Interface

| Campo | Tipo/Formato | Obrigatório | Descrição | Regra de Negócio |
|---|---|---|---|---|
| Matrícula do Professor | Texto (20) | Sim | Identificação do professor | Deve possuir vínculo ativo |
| Nome do Professor | Texto | Sim | Nome completo | Obtido automaticamente |
| Data/Hora da Retirada | Data/Hora | Sim | Momento da retirada | Gerado automaticamente |
| Leitura QR Code | QR Code | Sim | Identificação do patrimônio | Deve localizar equipamento válido |
| Aproximação NFC/RFID | NFC/RFID | Não | Identificação alternativa | Opcional |
| Número Patrimonial | Texto (20) | Sim | Código do patrimônio | Obtido automaticamente |
| Modelo do Projetor | Texto (100) | Sim | Modelo do equipamento | Obtido automaticamente |
| Status do Equipamento | Lista | Sim | Situação atual do equipamento | Deve estar “Disponível” |
| Bloco | Lista | Sim | Bloco do local de utilização | Deve existir cadastro válido |
| Sala/Laboratório | Lista | Sim | Sala destino do equipamento | Deve existir cadastro ativo |
| Local Manual | Texto (200) | Não | Local alternativo | Obrigatório quando “Outro Local” for selecionado |
| Cabo HDMI | Checkbox | Não | Acessório retirado | Vinculado à retirada |
| Cabo de Energia | Checkbox | Não | Acessório retirado | Vinculado à retirada |
| Controle Remoto | Checkbox | Não | Acessório retirado | Vinculado à retirada |
| Adaptador VGA/HDMI | Checkbox | Não | Acessório retirado | Vinculado à retirada |
| Extensão Elétrica | Checkbox | Não | Acessório retirado | Vinculado à retirada |
| Observações | Texto Longo (500) | Não | Observações adicionais | Campo livre |
| Termo de Responsabilidade | Texto/RichText | Sim | Termo eletrônico | Deve ser exibido |
| Aceite do Termo | Checkbox | Sim | Confirmação eletrônica | Obrigatório |
| Botão “Confirmar Retirada” | Botão | Sim | Finaliza operação | Habilitado após aceite |
| Botão “Cancelar” | Botão | Não | Cancela operação | Descarta alterações |
| Comprovante Eletrônico | PDF/Tela | Não | Comprovante final | Gerado automaticamente |

---

## 13.2 Navegabilidade

| Ação | Resultado |
|---|---|
| Ler QR Code/NFC válido | Sistema carrega os dados do equipamento |
| Ler QR Code inválido | Sistema exibe mensagem de erro |
| Selecionar sala/local | Sistema vincula local à movimentação |
| Selecionar acessórios | Sistema vincula acessórios |
| Não aceitar termo | Confirmação permanece desabilitada |
| Confirmar retirada | Sistema registra movimentação |
| Cancelar operação | Sistema encerra o fluxo |

---

## 13.3 Mensagens Previstas

| Código | Mensagem |
|---|---|
| MSG001 | Equipamento não encontrado |
| MSG002 | Equipamento indisponível para retirada |
| MSG003 | Professor não autorizado |
| MSG004 | Aceite do termo é obrigatório |
| MSG005 | Retirada realizada com sucesso |
| MSG006 | Falha na comunicação com sistema patrimonial |
| MSG007 | Sala/local de utilização obrigatório |

---

## 13.4 Componentes Visuais

| Área | Componente |
|---|---|
| Identificação do equipamento | Leitor QR Code/NFC |
| Dados do projetor | Card informativo |
| Local de utilização | Combos de bloco/sala |
| Seleção de acessórios | Lista de checkboxes |
| Termo de responsabilidade | Modal ou painel |
| Confirmação | Botões de ação |
| Comprovante | PDF ou visualização em tela |

---

# 14. Observações

| Código | Observação |
|---|---|
| OBS01 | O sistema poderá integrar assinatura digital institucional |
| OBS02 | Poderá existir reserva antecipada de equipamentos |
| OBS03 | Poderá existir aplicativo mobile institucional |
| OBS04 | Fluxo desenvolvido para autoatendimento |

---

# 15. Referências

| Código | Referência |
|---|---|
| REF01 | Sistema Patrimonial Institucional |
| REF02 | Política de Controle Patrimonial |
| REF03 | Documento de Requisitos Não Funcionais (RNF) |
| REF04 | Visão da Demanda do Projeto LAPIS |

---

# 16. Checklist de Validação do Artefato (CDU)

## 16.1 Estrutura mínima

- [x] Nome do caso de uso iniciado com verbo no infinitivo.
- [x] Objetivo claro, direto e com foco em um objetivo principal.
- [x] Tipo do caso de uso informado.
- [x] Atores primário e secundários identificados corretamente.
- [x] Precondições registradas.
- [x] Fluxo principal completo e coerente com o objetivo.
- [x] Fluxos alternativos e de exceção definidos.
- [x] Pós-condições registradas.
- [x] Requisitos não funcionais registrados.
- [x] Pontos de extensão identificados.
- [x] Frequência de utilização estimada.

---

## 16.2 Qualidade da especificação

- [x] Passos escritos com linguagem simples e objetiva.
- [x] Ações descritas no presente do indicativo.
- [x] Alternância entre ação do ator e sistema está clara.
- [x] Não há ambiguidade.
- [x] Regras de negócio e mensagens referenciadas.

---

## 16.3 Consistência e rastreabilidade

- [x] Fluxos alternativos possuem entrada e saída explícitas.
- [x] Fluxos de exceção vinculados corretamente.
- [x] Referências internas consistentes.
- [x] Interface visual coerente com o fluxo.
- [x] Referências atualizadas.

---

## 16.4 Revisão final

- [x] Não há contradições entre seções.
- [x] Documento revisado.
- [x] Artefato pronto para desenvolvimento e testes.

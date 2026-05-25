# Especificação de Requisitos Funcionais

## Caso de Uso (CDU) - LAPIS

---

## Histórico de Versões

| Data       | Versão | Descrição                                                                  | Autor             |
|------------|---------|----------------------------------------------------------------------------|-------------------|
| 25/05/2026 | 1.0     | Criação do caso de uso de devolução de projetor patrimonial                | Marcelo Alcantara |

---

# 1. Nome do Caso de Uso

**Devolver Projetor Patrimonial**

---

# 2. Objetivo

Permitir que o atendente realize o processo de devolução de projetores e acessórios, verificando as condições físicas do equipamento através de checklist de conferência e registrando eletronicamente a devolução patrimonial.

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
| Atendente | Realiza a conferência, checklist e devolução do equipamento |

---

## 4.2 Secundário

| Ator | Descrição |
|---|---|
| Professor | Responsável pela devolução física do equipamento |
| Sistema Patrimonial | Responsável pela atualização patrimonial |
| Sistema de Autenticação Institucional | Responsável pela autenticação do atendente |

---

# 5. Precondições

| Código | Descrição |
|---|---|
| PRE01 | O atendente deve estar autenticado no sistema |
| PRE02 | O equipamento deve estar vinculado a uma retirada ativa |
| PRE03 | O equipamento deve possuir identificação patrimonial válida |
| PRE04 | O equipamento deve possuir status “Em Uso” |

---

# 6. Fluxo Principal

## P1. Acessar funcionalidade de devolução

### P1.1.
O atendente acessa a funcionalidade de devolução de equipamentos.

---

## P2. Identificar equipamento

### P2.1.
O atendente realiza a leitura do QR Code do projetor.

### P2.2.
Alternativamente, o atendente aproxima o equipamento do leitor NFC/RFID.

### P2.3.
O sistema identifica o equipamento patrimonial.

### P2.4.
O sistema apresenta:
- Número patrimonial;
- Modelo do equipamento;
- Professor responsável;
- Data da retirada;
- Acessórios vinculados.

---

## P3. Conferir equipamento

### P3.1.
O atendente realiza inspeção visual do equipamento.

### P3.2.
O sistema apresenta checklist de conferência.

### P3.3.
O atendente verifica:
- Estado físico do projetor;
- Funcionamento do equipamento;
- Presença dos acessórios;
- Integridade dos cabos;
- Funcionamento do controle remoto.

### P3.4.
O atendente marca os itens conferidos.

---

## P4. Registrar observações

### P4.1.
O atendente informa ocorrências identificadas durante a conferência.

### P4.2.
O sistema registra observações de avarias ou ausência de acessórios.

---

## P5. Confirmar devolução

### P5.1.
O atendente confirma a devolução do equipamento.

### P5.2.
O sistema registra:
- Equipamento devolvido;
- Data e hora da devolução;
- Atendente responsável;
- Resultado do checklist;
- Observações registradas.

---

## P6. Finalizar operação

### P6.1.
O sistema altera o status do equipamento para “Disponível”.

### P6.2.
O sistema encerra a movimentação patrimonial.

### P6.3.
O sistema gera comprovante eletrônico de devolução.

---

# 7. Fluxos Alternativos

## A1. Equipamento com avaria

### A1.1.
O atendente identifica dano físico ou falha no funcionamento.

### A1.2.
O atendente registra observação detalhada.

### A1.3.
O sistema altera o status do equipamento para “Manutenção”.

### A1.4.
O fluxo segue para confirmação da devolução.

---

## A2. Acessórios não devolvidos

### A2.1.
O atendente identifica ausência de acessórios.

### A2.2.
O sistema permite registrar os itens pendentes.

### A2.3.
O sistema associa pendência à devolução.

---

## A3. Falha na leitura do QR Code

### A3.1.
O sistema não identifica o QR Code ou NFC/RFID.

### A3.2.
O atendente realiza busca manual pelo número patrimonial.

### A3.3.
O fluxo retorna ao passo P2.3.

---

# 8. Fluxos de Exceção

## E1. Equipamento não encontrado

### E1.1.
O sistema não localiza o patrimônio informado.

### E1.2.
O sistema exibe mensagem de erro.

### E1.3.
O caso de uso é encerrado.

---

## E2. Equipamento sem retirada ativa

### E2.1.
O sistema identifica ausência de empréstimo ativo.

### E2.2.
O sistema bloqueia a devolução.

### E2.3.
O atendente é orientado a procurar suporte administrativo.

---

## E3. Falha de comunicação com sistema patrimonial

### E3.1.
O sistema não consegue atualizar os dados patrimoniais.

### E3.2.
O sistema exibe mensagem de indisponibilidade temporária.

### E3.3.
O caso de uso é interrompido.

---

# 9. Pós-condições

| Código | Descrição |
|---|---|
| POS01 | O equipamento fica disponível para nova retirada |
| POS02 | A movimentação patrimonial é encerrada |
| POS03 | O checklist da devolução é armazenado |
| POS04 | As ocorrências identificadas ficam registradas |

---

# 10. Requisitos Não Funcionais

| Código | Requisito |
|---|---|
| RNF01 | O sistema deve registrar data e hora da devolução |
| RNF02 | O checklist deve permitir marcação rápida dos itens |
| RNF03 | O sistema deve manter rastreabilidade completa das movimentações |
| RNF04 | O sistema deve funcionar em desktop, tablet e totem |
| RNF05 | O histórico das devoluções deve permanecer armazenado por no mínimo 5 anos |
| RNF06 | O sistema deve permitir anexar observações de avarias |

---

# 11. Ponto de Extensão

## PE1. Registrar Manutenção de Equipamento

Permite encaminhar automaticamente o equipamento para manutenção quando identificada avaria.

---

# 12. Frequência de Utilização

| Item | Informação |
|---|---|
| Frequência | Alta |
| Perfil de Uso | Utilização diária pelos atendentes |
| Informações mais acessadas | Patrimônio, checklist e histórico de devolução |

---

# 13. Interface Visual

## IV1. Tela de Devolução de Equipamentos

### Leiaute da Tela

Tela utilizada pelo atendente para realizar a devolução e conferência do equipamento.

---

## 13.1 Campos da Interface

| Campo | Tipo/Formato | Obrigatório | Descrição | Regra de Negócio |
|---|---|---|---|---|
| Matrícula do Atendente | Texto (20) | Sim | Identificação do atendente | Deve possuir permissão ativa |
| Nome do Atendente | Texto | Sim | Nome completo do atendente | Obtido automaticamente |
| Data/Hora da Devolução | Data/Hora | Sim | Momento da devolução | Gerado automaticamente |
| Leitura QR Code | QR Code | Sim | Identificação do patrimônio | Deve localizar equipamento válido |
| Aproximação NFC/RFID | NFC/RFID | Não | Identificação alternativa | Opcional |
| Número Patrimonial | Texto (20) | Sim | Código do patrimônio | Obtido automaticamente |
| Modelo do Projetor | Texto (100) | Sim | Modelo do equipamento | Obtido automaticamente |
| Professor Responsável | Texto | Sim | Responsável pela retirada | Obtido automaticamente |
| Status do Equipamento | Lista | Sim | Situação atual | Deve estar “Em Uso” |
| Cabo HDMI Devolvido | Checkbox | Não | Confirma devolução do acessório | Vinculado ao checklist |
| Cabo de Energia Devolvido | Checkbox | Não | Confirma devolução do acessório | Vinculado ao checklist |
| Controle Remoto Devolvido | Checkbox | Não | Confirma devolução do acessório | Vinculado ao checklist |
| Adaptador VGA/HDMI Devolvido | Checkbox | Não | Confirma devolução do acessório | Vinculado ao checklist |
| Extensão Elétrica Devolvida | Checkbox | Não | Confirma devolução do acessório | Vinculado ao checklist |
| Equipamento Funcionando | Checkbox | Sim | Indica funcionamento do equipamento | Obrigatório |
| Equipamento Sem Danos | Checkbox | Sim | Indica ausência de avarias | Obrigatório |
| Observações | Texto Longo (1000) | Não | Registro de ocorrências | Campo livre |
| Botão “Confirmar Devolução” | Botão | Sim | Finaliza devolução | Habilitado após checklist |
| Botão “Cancelar” | Botão | Não | Cancela operação | Descarta alterações |
| Comprovante Eletrônico | PDF/Tela | Não | Comprovante da devolução | Gerado automaticamente |

---

## 13.2 Navegabilidade

| Ação | Resultado |
|---|---|
| Ler QR Code/NFC válido | Sistema carrega os dados do equipamento |
| Ler QR Code inválido | Sistema exibe mensagem de erro |
| Marcar checklist | Sistema valida conferência |
| Identificar avaria | Sistema permite registrar ocorrência |
| Confirmar devolução | Sistema registra devolução |
| Cancelar operação | Sistema encerra o fluxo |

---

## 13.3 Mensagens Previstas

| Código | Mensagem |
|---|---|
| MSG001 | Equipamento não encontrado |
| MSG002 | Equipamento sem retirada ativa |
| MSG003 | Devolução realizada com sucesso |
| MSG004 | Checklist obrigatório para conclusão |
| MSG005 | Equipamento encaminhado para manutenção |
| MSG006 | Falha na comunicação com sistema patrimonial |

---

## 13.4 Componentes Visuais

| Área | Componente |
|---|---|
| Identificação do equipamento | Leitor QR Code/NFC |
| Dados do projetor | Card informativo |
| Checklist de conferência | Lista de checkboxes |
| Observações | Campo texto multilinha |
| Confirmação | Botões de ação |
| Comprovante | PDF ou visualização em tela |

---

# 14. Observações

| Código | Observação |
|---|---|
| OBS01 | O checklist poderá ser parametrizável |
| OBS02 | O sistema poderá permitir anexar fotos de avarias |
| OBS03 | O sistema poderá integrar abertura automática de chamados de manutenção |
| OBS04 | Fluxo desenvolvido para operação pelo atendente |

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


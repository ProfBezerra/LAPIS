# Especificação de Requisitos Não Funcionais

> **Exemplo preenchido — Sistema de Gestão das Feiras Livres de Fortaleza**
>
> Este exemplo mostra como registrar requisitos não funcionais de forma objetiva, mensurável e ligada ao contexto de uma feira livre municipal.

## Histórico de Versões

| Data        | Versão | Descrição                                                                 | Autor         |
| ----------- | ------ | ------------------------------------------------------------------------- | ------------- |
| 09/05/2026  | 1.0    | Criação inicial do exemplo de requisitos não funcionais para feira livre  | Equipe Lapis  |

## 1. Requisitos de Produto

### 1.1. Eficiência de Desempenho

#### 1.1.1. Comportamento temporal

O sistema deve responder às consultas de feirantes, barracas, taxas e licenças em até 3 segundos para 95% das requisições durante o horário de funcionamento das feiras.

#### 1.1.2. Capacidade

O sistema deve suportar ao menos 500 usuários simultâneos, considerando servidores, fiscais e administradores acessando a plataforma em dias de pico de cadastro e fiscalização.

#### 1.1.3. Uso de recursos

O sistema deve operar de forma estável em servidores disponibilizados pela prefeitura, sem ultrapassar 80% de uso médio de CPU e memória em uso normal.

### 1.2. Flexibilidade (portabilidade)

#### 1.2.1. Escalabilidade

O sistema deve permitir aumento de carga sem necessidade de reescrita da aplicação, suportando crescimento do número de feiras, feirantes e registros de arrecadação.

#### 1.2.2. Adaptabilidade

O sistema deve funcionar em navegadores web modernos, como Chrome, Edge e Firefox, sem exigir instalação local nos computadores da secretaria ou dos fiscais.

#### 1.2.3. Instalabilidade

A solução deve ser instalável em ambiente de homologação e produção com procedimento documentado, permitindo reinstalação em até 2 horas.

### 1.3. Confiabilidade

#### 1.3.1. Disponibilidade

O sistema deve permanecer disponível em horário comercial com índice mínimo de 99% ao mês, exceto em manutenções programadas.

#### 1.3.2. Tolerância a falhas

Se houver falha temporária de conexão com o banco de dados, o sistema deve preservar os dados já informados pelo usuário e permitir retomar o processo sem perda de informação.

#### 1.3.3. Recuperabilidade

Após falha crítica, o sistema deve permitir restauração do serviço com perda máxima de 15 minutos de dados, usando cópias de segurança automáticas.

### 1.4. Segurança

#### 1.4.1. Confidencialidade

Dados pessoais de feirantes, fiscais e administradores devem ser acessíveis apenas a usuários autenticados e autorizados conforme seu perfil de acesso.

#### 1.4.2. Integridade

O sistema deve registrar trilha de auditoria para inclusão, alteração e exclusão de cadastros de feirantes, barracas e taxas.

#### 1.4.3. Autenticidade (autenticação)

Toda ação administrativa deve exigir autenticação individual do usuário, com senha forte ou mecanismo equivalente definido pela prefeitura.

#### 1.4.4. Resistência

O sistema deve aplicar proteção contra tentativas de acesso indevido, incluindo bloqueio temporário após múltiplas tentativas de login inválidas.

### 1.5. Privacidade

#### 1.5.1. Licitude

O tratamento de dados pessoais de feirantes deve estar vinculado à finalidade administrativa de cadastro, fiscalização e cobrança de taxas, conforme a legislação aplicável.

#### 1.5.2. Finalidade

Os dados coletados devem ser usados exclusivamente para gestão das feiras livres, emissão de licenças e controle de arrecadação.

#### 1.5.3. Necessidade

O sistema deve solicitar apenas os dados indispensáveis ao processo, como nome, CPF, telefone, produto comercializado e vínculo com a feira.

#### 1.5.4. Tratamento

O sistema deve permitir a exclusão ou anonimização de dados quando não houver mais base legal para retenção, respeitando regras de guarda documental.

### 1.6. Capacidade de Interação (UX + usabilidade + acessibilidade)

#### 1.6.1. Facilidade de aprendizado

O fluxo de cadastro de feirante deve ser concluído por um usuário treinado em até 5 minutos, sem necessidade de orientação adicional.

#### 1.6.2. Operabilidade

As telas principais devem ser organizadas com linguagem simples e rótulos compatíveis com o vocabulário usado pela secretaria e pelos fiscais.

#### 1.6.3. Proteção contra erros do usuário

O sistema deve validar CPF, campos obrigatórios e datas antes do envio do formulário, evitando registros inválidos e orientando a correção quando necessário.

#### 1.6.4. Inclusividade (acessibilidade)

A interface deve atender aos critérios básicos de contraste, navegação por teclado e leitura por tecnologias assistivas.

#### 1.6.5. Assistência ao usuário

O sistema deve exibir mensagens de erro objetivas e orientações claras para correção de campos inválidos.

### 1.7. Manutenibilidade

#### 1.7.1. Modularidade

As funções de cadastro, pagamento, fiscalização e relatório devem ser separadas em módulos independentes para reduzir impacto de mudanças.

#### 1.7.2. Testabilidade

O sistema deve expor regras de negócio de forma que possam ser testadas automaticamente com casos de uso e cenários de validação.

#### 1.7.3. Analisabilidade

A solução deve registrar logs suficientes para permitir diagnóstico rápido de falhas, inclusive em integrações com outros sistemas da prefeitura, sem expor dados pessoais desnecessários.

### 1.8. Compatibilidade

#### 1.8.1. Interoperabilidade

O sistema deve conseguir integrar-se com serviços internos da prefeitura para validação de licenças e autenticação de usuários.

#### 1.8.2. Coexistência

A aplicação deve compartilhar infraestrutura com outros sistemas municipais sem conflito de portas, bancos ou dependências críticas.

### 1.9. Segurança Operacional (safety)

#### 1.9.1. Restrição operacional

Operações críticas, como cancelamento de licença ou exclusão de cadastro, devem exigir confirmação explícita do usuário.

#### 1.9.2. Identificação de riscos

O sistema deve alertar quando uma barraca for associada a um feirante sem licença válida ou quando houver duplicidade de cadastro.

#### 1.9.3. Segurança contra falhas (fail-safe)

Em caso de erro grave, o sistema deve interromper apenas a operação afetada e preservar os demais dados já registrados.

#### 1.9.4. Aviso de perigo

O sistema deve exibir aviso imediato quando houver tentativa de registrar taxa fora do período autorizado ou em condição inconsistente.

#### 1.9.5. Integração segura

Toda integração com outros sistemas deve usar comunicação autenticada e criptografada.

### 1.10. Adequação funcional

#### 1.10.1. Completude funcional

O sistema deve contemplar cadastro de feirantes, controle de barracas, pagamento de taxas, fiscalização e geração de relatórios.

#### 1.10.2. Corretude funcional

Os relatórios de arrecadação devem apresentar valores consistentes com os pagamentos registrados no sistema.

#### 1.10.3. Adequação funcional

Cada funcionalidade deve apoiar diretamente a gestão das feiras livres, sem incluir recursos fora do escopo administrativo.

## 2. Requisitos Externos

### 2.1. Ético

O sistema deve operar de forma transparente, evitando práticas que possam prejudicar feirantes ou gerar tratamento desigual entre usuários.

### 2.2. Regulatório

A solução deve atender às normas internas da prefeitura para cadastro, cobrança, fiscalização e acesso por perfis de usuário.

### 2.3. Legislativo

O sistema deve respeitar a legislação municipal vigente relacionada ao funcionamento das feiras livres e ao tratamento de dados pessoais.

## 3. Requisitos Organizacionais

### 3.1. Ambientais

A solução deve ser executada em ambiente de servidor disponibilizado pela prefeitura e acessada via rede institucional ou internet, conforme política do órgão.

### 3.2. Operacionais

O sistema deve ser utilizado por servidores da secretaria, fiscais e administradores com perfis de acesso distintos e rastreáveis.

### 3.3. Desenvolvimento

O desenvolvimento deve seguir padrões definidos pela equipe do projeto, com versionamento em repositório, revisão de código e documentação mínima das regras de negócio.

## Como usar este exemplo

- Substitua os valores numéricos por metas reais do projeto quando elas existirem.
- Inclua outras categorias de RNF se o contexto exigir, como desempenho de relatórios, restrições legais específicas ou integração com sistemas legados.
- Use este documento como base para a especificação oficial, não como versão final sem validação com o cliente.

---

## Observações de uso

- Os requisitos devem ser reescritos com métricas reais do projeto, se houver disponibilidade de dados mais precisos.
- O exemplo acima pode ser adaptado para outros contextos de feira livre, como bairro, município ou edital específico.
- Para um documento final, recomenda-se complementar com o glossário e com a visão da demanda.

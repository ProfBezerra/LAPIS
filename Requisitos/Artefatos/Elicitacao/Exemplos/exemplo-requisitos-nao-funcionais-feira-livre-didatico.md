# Exemplo Didático de Requisitos Não Funcionais

> **Tema:** Sistema de Gestão das Feiras Livres de Fortaleza  
> **Objetivo:** mostrar, de forma simples, como escrever requisitos não funcionais para um sistema de feira livre.

## 1. O que este exemplo ensina?

Este documento apresenta requisitos não funcionais em linguagem mais direta, para ajudar estudantes e iniciantes a entenderem como transformar necessidades do contexto em critérios que possam ser verificados.

Os requisitos estão organizados por categoria, como desempenho, segurança, usabilidade e compatibilidade.

## 2. Histórico de Versões

| Data       | Versão | Descrição                                                           | Autor        |
| ---------- | ------ | ------------------------------------------------------------------- | ------------ |
| 09/05/2026 | 1.0    | Criação do exemplo didático de requisitos não funcionais            | Equipe Lapis |

## 3. Exemplo de Requisitos Não Funcionais

### 3.1. Desempenho

#### 3.1.1. Tempo de resposta

O sistema deve responder às consultas de feirantes, barracas e taxas em até 3 segundos na maioria dos casos de uso.

#### 3.1.2. Quantidade de usuários

O sistema deve suportar vários servidores, fiscais e administradores acessando a solução ao mesmo tempo, sem travar em horários de maior uso.

### 3.2. Confiabilidade

#### 3.2.1. Disponibilidade

O sistema deve ficar disponível para uso durante o horário de funcionamento da prefeitura e das feiras, exceto em manutenções planejadas.

#### 3.2.2. Recuperação de falhas

Se houver falha no sistema ou no banco de dados, os dados já digitados não devem ser perdidos e o serviço deve poder ser retomado rapidamente.

### 3.3. Segurança

#### 3.3.1. Controle de acesso

Somente usuários autenticados devem conseguir acessar funções administrativas, como cadastro, edição e exclusão de registros.

#### 3.3.2. Proteção de dados

Os dados pessoais de feirantes devem ser protegidos contra acesso não autorizado.

#### 3.3.3. Registro de ações

O sistema deve guardar histórico das alterações feitas nos cadastros, para permitir auditoria depois.

### 3.4. Usabilidade e acessibilidade

#### 3.4.1. Facilidade de uso

As telas principais do sistema devem ser simples, com linguagem clara e botões fáceis de localizar.

#### 3.4.2. Prevenção de erros

O sistema deve validar campos obrigatórios, como CPF e telefone, antes de salvar os dados.

#### 3.4.3. Acessibilidade

A interface deve permitir navegação por teclado e oferecer contraste adequado para leitura.

### 3.5. Compatibilidade

#### 3.5.1. Navegadores web

O sistema deve funcionar em navegadores modernos, como Chrome, Edge e Firefox.

#### 3.5.2. Integração

Se houver sistemas da prefeitura para validar licença ou autenticação, o sistema deve conseguir se integrar com eles.

### 3.6. Manutenibilidade

#### 3.6.1. Facilidade de alteração

O sistema deve ser organizado em módulos para facilitar mudanças futuras sem afetar todas as funcionalidades.

#### 3.6.2. Testabilidade

As regras principais do sistema devem poder ser testadas automaticamente.

## 4. Como transformar isso em requisito bem escrito?

Compare estas duas versões:

- Frase vaga: o sistema deve ser rápido.
- Frase melhor: o sistema deve responder às consultas em até 3 segundos.

A segunda versão é melhor porque diz o que será medido.

## 5. Exercícios para sala de aula

1. Reescreva o requisito "o sistema deve ser seguro" de forma mais objetiva.
2. Crie um requisito não funcional para a impressão de relatórios de arrecadação.
3. Escreva um requisito de acessibilidade para usuários com baixa visão.
4. Pense em uma situação de falha e descreva como o sistema deve se comportar.

## 6. Observações finais

Este exemplo não substitui a especificação oficial do projeto. Ele serve como apoio para aprender a identificar e escrever requisitos não funcionais de forma clara, mensurável e ligada ao contexto da feira livre.

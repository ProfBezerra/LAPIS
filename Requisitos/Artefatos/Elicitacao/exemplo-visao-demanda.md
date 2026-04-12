# Visão da Demanda (VD)

> **Exemplo preenchido — Projeto: Portal de Estágios**

## Histórico de Versões

<table border="1" width="100%">
<colgroup>
    <col style="width: 12%" />
    <col style="width: 8%" />
    <col style="width: 66%" />
    <col style="width: 12%" />
</colgroup>
<thead>
    <tr>
        <th style="text-align: center;"><strong>Data</strong></th>
        <th style="text-align: center;"><strong>Versão</strong></th>
        <th style="text-align: center;"><strong>Descrição</strong></th>
        <th style="text-align: center;"><strong>Autor</strong></th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>12/04/2026</td>
        <td>1.0</td>
        <td>Criação inicial do documento de visão para o Portal de Estágios</td>
        <td>Equipe Lapis</td>
    </tr>
</tbody>
</table>

## 1. Objetivo

Este documento visa definir a proposta de valor da demanda "Portal de Estágios", detalhando as necessidades dos alunos, professores e setor administrativo.

## 2. Proposta de Valor

A solução permitirá que alunos solicitem estágios online, reduzindo o tempo de aprovação de 10 para 2 dias e eliminando processos em papel. Professores e setor administrativo terão maior controle e transparência sobre o andamento dos estágios.

## 3. Descrição da Demanda

O sistema permitirá cadastro de vagas, inscrição de alunos, acompanhamento de estágios e geração de relatórios para o setor administrativo. Todo o fluxo será digital, com notificações automáticas e integração ao sistema acadêmico.

## 4. Partes Interessadas

| Nome                  | Papel           | Responsabilidades                        | Representante         |
|-----------------------|-----------------|------------------------------------------|-----------------------|
| Setor de Estágios     | Cliente         | Aprovar vagas, acompanhar estágios       | Maria Souza           |
| Aluno                 | Usuário final   | Solicitar e acompanhar estágio           | -                     |
| Professor Orientador  | Stakeholder     | Avaliar e aprovar relatórios             | Prof. João Lima       |
| Equipe de TI          | Desenvolvimento | Implementar e manter o sistema           | Equipe Lapis          |

## 5. Personas

### 5.1. Aluno
- **Descrição:** Estudante de graduação que busca estágio obrigatório.
- **Objetivo:** Conseguir estágio e acompanhar o processo online.

### 5.2. Professor Orientador
- **Descrição:** Docente responsável por aprovar relatórios de estágio.
- **Objetivo:** Avaliar e aprovar relatórios de forma ágil.

## 6. Necessidades e Funcionalidades

### Necessidade 1: Solicitar estágio

#### F1.1 Cadastro de solicitação de estágio
- **Descrição:** Permite ao aluno cadastrar uma nova solicitação de estágio.
- **Incluída**
- **Atores:** Aluno
- **Frequência:** Alta
- **Valor:** Alto

### Necessidade 2: Aprovar relatório

#### F2.1 Aprovação de relatório de estágio
- **Descrição:** Permite ao professor aprovar ou rejeitar relatórios enviados.
- **Incluída**
- **Atores:** Professor Orientador
- **Frequência:** Média
- **Valor:** Alto

## 7. Arquitetura da Demanda

O sistema será composto por três módulos principais: Portal do Aluno, Portal do Professor e Módulo Administrativo. Integração com sistema acadêmico via API REST.

Sugestão: utilizar mapas de histórias ou diagramas de caso de uso (UML) para ilustrar.

---

## Checklist de Validação do Documento de Visão

- [x] O objetivo está claro e alinhado ao problema/necessidade?
- [x] A proposta de valor é mensurável e relevante?
- [x] Todas as partes interessadas estão listadas com papéis definidos?
- [x] Existem pelo menos duas personas descritas?
- [x] Todas as necessidades e funcionalidades estão relacionadas a atores?
- [x] Há indicação de valor e frequência para cada funcionalidade?
- [x] A arquitetura está ilustrada (mesmo que de forma simples)?
- [x] O documento está escrito em linguagem clara e objetiva?

---

> Consulte exemplos e dicas em: [Guia de Elaboração da Visão](../../Elicitacao/VisaoDemanda.md)

# Visão da Demanda (VD)

> **Orientação:**
>
> 1. Copie este template para cada nova demanda/projeto.
> 2. Preencha cada seção com informações claras, objetivas e sem jargões técnicos desnecessários.
> 3. Consulte o [guia de elaboração](../../../Elicitacao/VisaoDemanda.md) para dicas e exemplos.
> 4. Use artefatos visuais (mapa de histórias, diagrama de caso de uso) sempre que possível.

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
        <td><dd/mm/aaaa></td>
        <td><x.x></td>
        <td><identificar a demanda e uma descrição sumária do que ocasionou a criação/mudança do artefato></td>
        <td><nome do autor></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
</tbody>
</table>

## 1. Objetivo

Descreva de forma sucinta o propósito do projeto/demanda.

**Exemplo:**

> Este documento visa definir a proposta de valor da demanda "Portal de Estágios", detalhando as necessidades dos alunos, professores e setor administrativo.

## 2. Proposta de Valor

Explique os benefícios que a solução trará para o cliente/usuário.

**Exemplo:**

> A solução permitirá que alunos solicitem estágios online, reduzindo o tempo de aprovação de 10 para 2 dias e eliminando processos em papel.

## 3. Descrição da Demanda

Apresente um resumo do problema, contexto e principais funcionalidades.

**Exemplo:**

> O sistema permitirá cadastro de vagas, inscrição de alunos, acompanhamento de estágios e geração de relatórios para o setor administrativo.

## 4. Partes Interessadas

Liste todos os envolvidos, seus papéis e responsabilidades.

**Exemplo:**

| Nome                 | Papel           | Responsabilidades                   | Representante    |
| -------------------- | --------------- | ----------------------------------- | ---------------- |
| Setor de Estágios   | Cliente         | Aprovar vagas, acompanhar estágios | Maria Souza      |
| Aluno                | Usuário final  | Solicitar e acompanhar estágio     | -                |
| Professor Orientador | Stakeholder     | Avaliar e aprovar relatórios       | Prof. João Lima |
| Equipe de TI         | Desenvolvimento | Implementar e manter o sistema      | Equipe Lapis     |

## 5. Personas

Descreva perfis típicos dos usuários ou sistemas que interagem com a solução.

**Exemplo:**

### 5.1. Aluno

- **Descrição:** Estudante de graduação que busca estágio obrigatório.
- **Objetivo:** Conseguir estágio e acompanhar o processo online.

### 5.2. Professor Orientador

- **Descrição:** Docente responsável por aprovar relatórios de estágio.

## 6. Necessidades e Funcionalidades

Relacione as necessidades e funcionalidades, detalhando para cada uma os atores, frequência e valor.

**Exemplo:**

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

Inclua um diagrama simples (pode ser desenhado à mão e digitalizado, ou feito em ferramenta online) mostrando os principais componentes e integrações.

**Exemplo:**

> O sistema será composto por três módulos principais: Portal do Aluno, Portal do Professor e Módulo Administrativo. Integração com sistema acadêmico via API REST.

Sugestão: utilize mapas de histórias ou diagramas de caso de uso (UML) para ilustrar.

---

## Checklist de Validação do Documento de Visão

- [ ] O objetivo está claro e alinhado ao problema/necessidade?
- [ ] A proposta de valor é mensurável e relevante?
- [ ] Todas as partes interessadas estão listadas com papéis definidos?
- [ ] Existem pelo menos duas personas descritas?
- [ ] Todas as necessidades e funcionalidades estão relacionadas a atores?
- [ ] Há indicação de valor e frequência para cada funcionalidade?
- [ ] A arquitetura está ilustrada (mesmo que de forma simples)?
- [ ] O documento está escrito em linguagem clara e objetiva?

---

> Consulte exemplos e dicas em: [Guia de Elaboração da Visão](../../../Elicitacao/VisaoDemanda.md)
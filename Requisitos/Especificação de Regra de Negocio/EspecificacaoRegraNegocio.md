# Documentando as Regras de Negócio da Solução

Última atualização em 10/05/2026

## O que é?

* Registrar as restrições, premissas e gatilhos de negócio que a solução deve atender ao realizar uma determinada funcionalidade.

## Por que realizar?

* Proporciona maior clareza na transmissão de informações sobre o que a solução deve ou não fazer.
* Documenta o contexto de negócio no qual a solução está inserida.
* Ajuda a garantir que uma tarefa de desenvolvimento seja executada e entregue de acordo com critérios específicos, o que é especialmente importante caso a solução envolva compliance com relação a alguma regra externa, por exemplo leis ou regulamentações.

## Quem realiza?

Integrante do time da solução

## Envolvidos

* Cliente
* Stakeholder
* Especialista no negócio da solução

## Quando realizar?

* Durante a construção para:
  * Construir nova solução
  * Evoluir solução
  * Corrigir solução

## Como realizar?

⚠️**Atenção:** Ao documentar as regras de negócio, utilize uma **linguagem simples**.

1. Nomeie a regra utilizando o formato sujeito + verbo + objeto.
   📌**Exemplo:** Usuários registrados como “gerente” podem aprovar crédito.
2. Utilize os identificadores para relacionar e fazer referência a regras em outras regras, fluxogramas e outras documentações. Desdobramentos de regras podem seguir o modelo RN1, RN1.1, RN1.2, etc.
3. Descreva a regra de negócio, considerando os seguintes atributos de qualidade:
   * Ter somente uma função (fazer somente uma coisa)
   * Ser completa (ter início, meio e fim definidos de forma explícita)
   * Ser inteligível, sucinta e clara (sem ambiguidades e dupla negação) para todas os stakeholders/partes interessadas
   * Ser mensurável, rastreável e verificável
   * Explicitar claramente qualquer regra de compliance que seja aplicável
   * Estar sempre atualizada
4. Se necessário, detalhe a descrição da regra, utilizando diagramas, fluxogramas ou UML.

⚠️**Atenção:** No  **Serpro** , as **regras de negócio** são utilizadas também para documentar:

* Regras de permissões do usuário
* Regras de trilhas de auditoria
  * Para cada funcionalidade auditada, informe:
    * Quem executou
    * Qual ação foi executada (inclusão, alteração, exclusão, consulta)
    * Quando a ação foi executada
    * Outras informações que o cliente e/ou usuário da solução defina como necessárias.
* Regras de histórico
* Regras de campos de tela (tipo, tamanho, máscara de formatação, origem do dado (fixo, mantido pela solução ou por outra solução), regras de exibição -campos exibidos e em qual ordem, obrigatoriedade, formatação condicional etc. - e links para ajuda)
* Regras de interfaces externas (o formato, a estrutura e os padrões adotados pelos meios de interação - arquivos, mensagens, conteúdo etc.)

## Artefatos

* Especificação de regras de negócio (RNG)

## Exemplos

* Não disponível.

## Ferramentas

## Referências

### Linguagem simples

* [Lei Nº 15.263, de 14 de novembro de 2025](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15263.htm) - Política Nacional de Linguagem Simples nos órgãos e entidades da administração pública direta e indireta de todos os Poderes da União, dos Estados, do Distrito Federal e dos Municípios

### Bibliográficas

* [Diferença de requisito funcional e regra de negócio](https://www.ateomomento.com.br/requisito-funcional-x-regra-de-negocio-quem-e-quem/)
* [O que são regras de negócio?](https://www.alura.com.br/artigos/o-que-sao-regras-de-negocio?srsltid=AfmBOopKW-5wV8k_uHAaZcMzrq6lHNMci_d3IgFrCy7Sa4Hg1nrjC8cH)
* [O que é regra de negócio?](https://www.ateomomento.com.br/o-que-e-regra-de-negocio/)
* [Roteiro de métricas de software do SISP versão 2.3](https://www.gov.br/governodigital/pt-br/estrategias-e-governanca-digital/sisp/documentos/arquivos/roteiro-de-metricas-do-sisp-v2-3.pdf/view)

## Checklist de Validação do Artefato (RNG)

Use este checklist antes de concluir a versão do documento.

### 1. Estrutura e identificação

* [ ] Cada regra possui identificador único (ex.: RN1, RN1.1, RN2).
* [ ] O nome da regra está no formato sujeito + verbo + objeto.
* [ ] A regra está descrita em linguagem simples e objetiva.
* [ ] Há separação clara entre regra principal e desdobramentos.

### 2. Qualidade da regra

* [ ] A regra possui apenas uma função (sem múltiplas decisões misturadas).
* [ ] A redação está sem ambiguidade e sem dupla negação.
* [ ] A regra é verificável e mensurável sempre que aplicável.
* [ ] A condição de aplicação (gatilho/contexto) está explícita.
* [ ] O resultado esperado da regra está explícito.

### 3. Compliance e rastreabilidade

* [ ] Regras legais/regulatórias relacionadas foram referenciadas.
* [ ] Regras de permissão e auditoria foram registradas quando aplicável.
* [ ] Há vínculo com artefatos relacionados (CDU, RNF, visão, protótipo).
* [ ] A origem da regra (negócio, norma, cliente) está identificada.

### 4. Prontidão para uso

* [ ] Não há conflito entre regras do mesmo domínio.
* [ ] O documento está atualizado com a versão vigente da solução.
* [ ] O conteúdo foi revisado por pares.
* [ ] O artefato está pronto para uso em análise, desenvolvimento e testes.

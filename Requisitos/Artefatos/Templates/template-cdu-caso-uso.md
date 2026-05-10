# Especificação de Requisitos Funcionais

## Caso de Uso (CDU) - LAPIS

## Histórico de Versões

<!-- markdownlint-disable MD060 -->
| Data       | Versão | Descrição                                                                                        | Autor         |
| ---------- | ------- | -------------------------------------------------------------------------------------------------- | ------------- |
| dd/mm/aaaa | x.x     | identificar a demanda e uma descrição sumária do que ocasionou a criação/mudança do artefato | nome do autor |
|            |         |                                                                                                    |               |
|            |         |                                                                                                    |               |
<!-- markdownlint-enable MD060 -->

## 1. Nome do Caso de Uso

> Utilize um nome que retrate claramente a ação a ser realizada.

## 2. Objetivo

> Descreva a finalidade do caso de uso

## 3. Tipo de Caso de Uso  <opcional\>

> Classifique o caso de uso em questão em Concreto ou Abstrato.

## 4. Atores

> Relacione os atores que interagem com o caso de uso, começando pelo ator que inicia a interação.

### 4.1 Primário

> Indentifique o ator que mais interage direta ou indiretamente com o caso de uso. Esse ator sempre inicia o caso de uso.

### 4.2 Secundário

> Relacione os atores que interage de forma passiva com o caso de uso.

## 5. Precondições <opcional\>

> Identifique as condições que devem ser satisfeitas para que o caso de uso possa iniciar.
>
> Na inexistência de precondições para o caso de uso, exclua a seção ou mantenha-a com a mensagem: “Não se aplica”.

## 6. Fluxo Principal

> Escolha o cenário que mais diretamente cumpre o objetivo do caso de uso para um dado ator

### P1. <Título do Passo\>

> Descreva o passo, utilizando uma sentença clara e objetiva que descreve a função que o passo declara.

### P1.1. <sentença sucinta descrevendo a função que o sub-passo declara.\>

> A adoção de sub-passos é opcional, sendo recomendada apenas para passos complexos.

## 7. Fluxos Alternativos

> Descreva os cenários alternativos utilizados pelos atores.

### A1. <descrição do fluxo alternativo\>

#### A1.1. <passo do fluxo alternativo\>

## 8. Fluxos de Exceção

> Descreva os cenários que apresentam os possíveis erros que podem ser observados durante a interação dos atores com o sistema.

### E1. <descrição do fluxo de exceção.\>

#### E1.1. <passo do fluxo de exceção.\>

## 9. Pós-condições <opcional\>

> Identifique as condições que podem ser garantidas como verdadeiras ao final do caso de uso.
>
> Na inexistência de pós-condições para o caso de uso, esta seção pode ser excluída ou mantida com a  mensagem: “Não se aplica”.

## 10. Requisitos Não Funcionais <opcional\>

> Enumere os requisitos não funcionais identificados especificamente para esse caso de uso que não são cobertos pelo fluxo de eventos, ou pela Especificação de requisitos não funcionais (RNF), mas que podem influenciar o desenvolvimento do sistema.
>
> Na inexistência de requisitos não funcionais específicos do caso de uso, esta seção pode ser excluída ou mantida com a  mensagem: “Não se aplica”.

## 11. Ponto de Extensão <opcional\>

> Referencie pontos de extensão que são referências a outros casos de uso do próprio sistema (extends) que complementam o fluxo de eventos do corpo do caso de uso chamador.
>
> Na inexistência de pontos de extensão, esta seção pode ser excluída ou mantida com a  mensagem: “Não se aplica”.

### PE1. <Título do ponto de extensão\>

> Descrição do ponto de extensão

## 12. Frequência de Utilização <opcional\>

> Informe se é alta, média ou baixa e quais informações são mais acessadas.
>
> Esta seção pode ser excluída ou mantida com a  mensagem: “Não se aplica”.

## 13. Interface Visual <opcional\>

> Apresente o leiaute das telas utilizadas nesse caso de uso.
>
> Nesse item, também defina navegabilidade e ajudas de contexto.
>
> Caso seja necessário, utilize um artefato em separado, indique o nome do arquivo.
>
> Esta seção pode ser excluída ou mantida com a  mensagem: “Não se aplica”.>

### IV1. <Título da Interface Visual\>

> Leiaute da Tela, referência à sua localização

## 14. Observações <opcional\>

> Registre anotações técnicas, informações adicionais a serem trabalhadas no futuro, ou lembretes.
>
> Esta seção pode ser excluída ou mantida com a mensagem: “Não se aplica”.

## 15. Referências <opcional\>

> Item disponível para citar os modelos, diagramas, funcionalidades e outros documentos que se relacionem ao caso de uso em questão.
>
> Esta seção pode ser excluída ou mantida com a  mensagem: “Não se aplica”.

## 16. Checklist de Validação do Artefato (CDU)

> Utilize este checklist antes de concluir a versão do caso de uso.

### 16.1 Estrutura mínima

* [ ] Nome do caso de uso iniciado com verbo no infinitivo.
* [ ] Objetivo claro, direto e com foco em um objetivo principal.
* [ ] Tipo do caso de uso informado (concreto/abstrato), quando aplicável.
* [ ] Atores primário e secundários identificados corretamente.
* [ ] Precondições registradas (ou seção marcada como "Não se aplica").
* [ ] Fluxo principal completo e coerente com o objetivo.
* [ ] Fluxos alternativos e de exceção definidos quando necessários.
* [ ] Pós-condições registradas (ou seção marcada como "Não se aplica").
* [ ] Requisitos não funcionais específicos do CDU registrados, quando existirem.
* [ ] Pontos de extensão identificados corretamente, quando existirem.
* [ ] Frequência de utilização estimada.

### 16.2 Qualidade da especificação

* [ ] Passos escritos com linguagem simples e objetiva.
* [ ] Ações descritas com verbos no presente do indicativo (3ª pessoa).
* [ ] Alternância entre ação do ator e ação da solução está clara.
* [ ] Não há ambiguidade (termos vagos sem detalhe técnico).
* [ ] Regras de negócio e mensagens estão referenciadas quando necessário.

### 16.3 Consistência e rastreabilidade

* [ ] Pontos de entrada e saída dos fluxos alternativos estão explícitos.
* [ ] Fluxos de exceção estão vinculados aos passos corretos da solução.
* [ ] Referências internas entre passos (retorna/segue para) estão corretas.
* [ ] Interface visual (IV1 etc.) está coerente com o fluxo descrito.
* [ ] Referências para visão da demanda, glossário e RNF estão atualizadas.

### 16.4 Revisão final

* [ ] Não há contradições entre seções do artefato.
* [ ] Links internos e externos foram validados.
* [ ] Documento revisado por pares.
* [ ] Artefato pronto para uso em desenvolvimento e testes.

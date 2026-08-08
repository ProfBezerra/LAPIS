# Especificação de Requisitos Funcionais

## Caso de Uso (CDU) - Jogo da Velha Web - UNIFOR

## Histórico de Versões

| Data       | Versão | Descrição                                     | Autor        |
| ---------- | ------- | ----------------------------------------------- | ------------ |
| 08/08/2026 | 1.0     | Criação do caso de uso de Jogar Jogo da Velha | Equipe LAPIS |

---

## 1. Nome do Caso de Uso

**Jogar Jogo da Velha**

## 2. Objetivo

Permitir que o usuário dispute partidas do Jogo da Velha em ambiente web, oferecendo modos contra outro jogador local ou contra o computador, formatos de partida única ou Melhor de 3 (MD3), acompanhamento do placar, efeitos visuais da linha vitoriosa, efeitos sonoros e confetes na vitória.

## 3. Tipo de Caso de Uso

**Concreto**

## 4. Atores

### 4.1 Primário

* **Jogador:** Inicia o caso de uso e realiza as jogadas no tabuleiro.

### 4.2 Secundário

* **Computador:** Solução interna/autômata que responde ativamente às jogadas do Jogador quando o modo contra IA está ativado.

## 5. Precondições

O Jogador deve acessar a aplicação web por meio de um navegador compatível com suporte a JavaScript e Web Audio API.

## 6. Fluxo Principal

* **P1.** O Jogador acessa a aplicação.
* **P2.** O sistema exibe a interface principal contendo a identificação da universidade ("UNIVERSIDADE DE FORTALEZA"), o título, os seletores de "Modo de Jogo" (2 Jogadores / Contra o Computador) e "Formato da Partida" (Partida Única / Melhor de 3), o placar zerado, o indicador de rodada, a mensagem de status da vez ("Vez do Jogador X"), o tabuleiro 3x3 com células vazias e o botão "Reiniciar Jogo".
* **P3.** O Jogador seleciona uma célula vazia do tabuleiro.
* **P4.** O sistema registra a jogada do jogador atual.
  * **P4.1.** Preenche a célula selecionada com o símbolo do jogador atual ('X' ou 'O').
  * **P4.2.** Toca o efeito sonoro sintetizado correspondente ao símbolo.
  * **P4.3.** Avalia o tabuleiro em busca de combinações vitoriosas nas linhas, colunas ou diagonais. **[E1]** **[A1]**
* **P5.** O sistema alterna o turno para o próximo jogador.
* **P6.** O sistema atualiza a mensagem de status exibindo a vez do próximo jogador.
* **P7.** O Jogador realiza a jogada seguinte. **[A2]**

---

## 7. Fluxos Alternativos

### A1. Fim de Rodada por Vitória

* **A1.1.** No passo **P4.3**, o sistema identifica três símbolos iguais alinhados em uma linha, coluna ou diagonal.
* **A1.2.** O sistema traça uma linha visual contínua sobre a sequência de três células vitoriosas.
* **A1.3.** O sistema dispara a animação de confetes.
* **A1.4.** O sistema toca o acorde sonoro sintetizado de vitória.
* **A1.5.** O sistema incrementa a pontuação do jogador vencedor no placar.
* **A1.6.** O sistema atualiza a mensagem de status declarando o vencedor da rodada.
* **A1.7.** Caso o formato selecionado seja **Melhor de 3 (MD3)**:
  * **A1.7.1.** Se algum jogador atingir 2 vitórias, o sistema declara o campeão definitivo da partida e encerra os turnos.
  * **A1.7.2.** Caso nenhum jogador tenha atingido 2 vitórias e a rodada seja menor que 3, o sistema incrementa o número da rodada, aguarda 2 segundos, limpa o tabuleiro, esconde a linha vitoriosa e retorna ao passo **P2** para a nova rodada.
* **A1.8.** Caso seja **Partida Única**, o jogo é finalizado até que ocorra um reinício manual.

### A2. Jogada do Computador (Modo Contra a CPU)

* **A2.1.** No passo **P7**, estando configurado o modo "Contra o Computador" e sendo a vez do jogador 'O':
* **A2.2.** O sistema bloqueia temporariamente novos cliques do Jogador.
* **A2.3.** O sistema aguarda um intervalo de reflexão (400ms).
* **A2.4.** O sistema escolhe uma posição vazia no tabuleiro.
* **A2.5.** O sistema executa o movimento do Computador na célula escolhida e segue para o passo **P4.1**.

### A3. Reinício da Partida / Alteração de Parâmetros

* **A3.1.** Em qualquer passo do jogo, o Jogador clica no botão "Reiniciar Jogo" ou altera qualquer um dos seletores ("Modo de Jogo" ou "Formato da Partida").
* **A3.2.** O sistema zera o placar de ambos os jogadores e o contador de rodadas.
* **A3.3.** O sistema oculta a linha vitoriosa e limpa todas as células do tabuleiro.
* **A3.4.** O sistema define o Jogador X como o primeiro a jogar.
* **A3.5.** O sistema retorna ao passo **P2**.

---

## 8. Fluxos de Exceção

### E1. Fim de Rodada por Empate

* **E1.1.** No passo **P4.3**, o sistema identifica que todas as 9 células foram preenchidas e nenhuma combinação vitoriosa foi alcançada.
* **E1.2.** O sistema toca o som descendente sintetizado de empate.
* **E1.3.** O sistema atualiza a mensagem de status exibindo "Rodada Empatada!".
* **E1.4.** Se o formato for **Melhor de 3 (MD3)** e a rodada for menor que 3, o sistema aguarda 2 segundos, limpa o tabuleiro e reinicia a rodada sem incrementar o número da rodada atual.

---

## 9. Pós-condições

Ao término de cada rodada ou partida, a pontuação acumulada é mantida no placar até o reinício manual, e a interface indica claramente o resultado final ou a preparação para a próxima rodada.

## 10. Requisitos Não Funcionais

* **Interface Institucional:** Aplicação de paleta de cores e tipografia correspondentes à identidade visual da UNIFOR (Azul `#003366`, Azul Destaque `#0056b3`, Laranja `#d97706` e Fundo `#f4f6f9`).
* **Sintetização de Áudio (Zero Dependência de Arquivos):** Efeitos sonoros gerados exclusivamente via Web Audio API nativa do navegador.
* **Portabilidade:** Execução completa contida em um único arquivo HTML/CSS/JS, sem necessidade de servidor back-end.

## 11. Ponto de Extensão

Não se aplica.

## 12. Frequência de Utilização

Uso recreativo e educacional frequente, com picos durante demonstrações ou aulas práticas de desenvolvimento front-end e engenharia de requisitos.

---

## 13. Interface Visual

### IV1. Visão Geral dos Elementos da Tela

| ID do Elemento  | Nome do Campo / Componente | Tipo de Componente            | Formato / Valoração / Opções                          | Estado Inicial / Padrão | Regra / Comportamento na Interface                                            |
| :-------------- | :------------------------- | :---------------------------- | :-------------------------------------------------------- | :----------------------- | :---------------------------------------------------------------------------- |
| **UI-01** | Subtítulo Institucional   | Texto                         | Texto em caixa alta (`UNIVERSIDADE DE FORTALEZA`)       | Fixo                     | Exibido no topo do cabeçalho em tom azul de destaque.                        |
| **UI-02** | Título Principal          | Texto / Heading (`<h1>`)    | Texto em caixa alta (`JOGO DA VELHA`)                   | Fixo                     | Título principal da aplicação em Azul UNIFOR (`#003366`).                |
| **UI-03** | Seletor de Modo            | Dropdown (`<select>`)       | •`2 Jogadores (PVP)`• `Contra o Computador`         | `2 Jogadores (PVP)`    | Ao ser alterado, zera o placar e altera o rótulo do Jogador O (UI-07).       |
| **UI-04** | Seletor de Formato         | Dropdown (`<select>`)       | •`Partida Única`• `Melhor de 3 (MD3)`              | `Partida Única`       | Ao ser alterado, zera o placar e ajusta a exibição das rodadas (UI-06).     |
| **UI-05** | Placar - Jogador X         | Valor Numérico               | Numérico inteiro ($\ge 0$)                             | `0`                    | Exibe o total de vitórias do Jogador X na cor azul.                          |
| **UI-06** | Contador de Rodada         | Texto                         | Formato`Atual/Total` (ex: `1/1` ou `1/3`)           | `1/1`                  | Exibe`1/1` em Partida Única e atualiza até `3/3` no modo Melhor de 3.   |
| **UI-07** | Placar - Jogador O / CPU   | Valor Numérico               | Numérico inteiro ($\ge 0$)                             | `0`                    | Exibe o total de vitórias do Jogador O ou Computador na cor laranja.         |
| **UI-08** | Status do Jogo             | Texto                         | Mensagem dinâmica (ex:`Vez do Jogador X`, `Empate!`) | `Vez do Jogador X`     | Atualiza a cada jogada ou término de rodada.                                 |
| **UI-09** | Células do Tabuleiro      | Botões Grid ($3 \times 3$) | Matriz de 9 botões com valores`''`, `'X'` ou `'O'` | Todas vazias (`''`)    | Ao clicar, insere o símbolo do jogador atual e desabilita a célula clicada. |
| **UI-10** | Linha de Vitória          | Div (`overlay`)             | Linha colorida esticada e rotacionada sobre o grid        | Oculta (`opacity: 0`)  | Calculada via CSS/JS para cobrir o centro das 3 células vitoriosas.          |
| **UI-11** | Botão Reiniciar           | Botão (`<button>`)         | Texto em caixa alta (`REINICIAR JOGO`)                  | Habilitado               | Zera placar, rodadas, limpa o tabuleiro e reseta para o turno do Jogador X.   |

### IV2. Protótipo de Interface (Wireframe Low-Fi)

```text
===================================================================
                     UNIVERSIDADE DE FORTALEZA
                          JOGO DA VELHA
===================================================================

 [ Modo de Jogo: 2 Jogadores (PVP) ▾ ]   [ Formato: Partida Única ▾ ]

 +---------------------------------------------------------------+
 |  JOGADOR X               RODADA                   JOGADOR O   |
 |     (0)                   1/1                        (0)      |
 +---------------------------------------------------------------+

                       Vez do Jogador X

                      +-----+-----+-----+
                      |     |     |     |
                      |  X  |  O  |  X  |
                      |     |     |     |
                      +-----+-----+-----+
                      |     |  \  |     |
                      |  O  |   \ |     |   <-- (Linha de Vitória)
                      |     |    \|     |
                      +-----+-----+-----+
                      |     |     |\    |
                      |     |  O  | \ X |
                      |     |     |  \  |
                      +-----+-----+-----+

                     [  REINICIAR JOGO  ]
===================================================================
```

---

## 14. Observações

- O fluxo deve continuar a ser validado com foco em usabilidade, feedback visual e sonoro.
- O caso de uso pode evoluir para incluir modos adicionais, como partida contra outro jogador remoto.

## 15. Referências

- Visão da Demanda do projeto LAPIS.
- Glossário do projeto.
- Especificação de Requisitos Não Funcionais.

## 16. Checklist de Validação do Artefato (CDU)

### 16.1 Estrutura mínima

* [X] Nome do caso de uso iniciado com verbo no infinitivo.
* [X] Objetivo claro, direto e com foco em um objetivo principal.
* [X] Tipo do caso de uso informado.
* [X] Atores primário e secundários identificados corretamente.
* [X] Precondições registradas.
* [X] Fluxo principal completo e coerente com o objetivo.
* [X] Fluxos alternativos e de exceção definidos.
* [X] Pós-condições registradas.
* [X] Requisitos não funcionais específicos do CDU registrados.
* [X] Frequência de utilização estimada.

### 16.2 Qualidade da especificação

* [X] Passos escritos com linguagem simples e objetiva.
* [X] Ações descritas com verbos no presente do indicativo.
* [X] Alternância entre ação do ator e ação da solução está clara.
* [X] Não há ambiguidade relevante.
* [X] Regras de negócio e mensagens foram referenciadas quando necessário.

### 16.3 Consistência e rastreabilidade

* [X] Pontos de entrada e saída dos fluxos alternativos estão explícitos.
* [X] Fluxos de exceção estão vinculados aos passos corretos da solução.
* [X] Referências internas entre passos estão corretas.
* [X] Interface visual está coerente com o fluxo descrito.
* [X] Referências para visão da demanda, glossário e RNF estão atualizadas.

### 16.4 Revisão final

* [X] Não há contradições entre seções do artefato.
* [X] Documento revisado por pares.
* [X] Artefato pronto para uso em desenvolvimento e testes.

## 17. Matriz de Rastreabilidade

| ID Requisito | Funcionalidade / Comportamento | Passo do Caso de Uso | Elemento da Interface | Regra de Negócio / Validação |
| --- | --- | --- | --- | --- |
| **RF-01** | Seleção de Modo de Jogo | P2, A2.1, A3.1 | UI-03 (Seletor de Modo) | Alterna entre lógica 2P e chamada de IA (CPU). |
| **RF-02** | Seleção de Formato (MD3) | P2, A1.7, A3.1 | UI-04 (Seletor de Formato) | Controla limite de vitórias ($\text{vitórias} = 2$) e contador de rodadas. |
| **RF-03** | Marcação de Jogada | P3, P4, A2.5 | UI-09 (Células do Tabuleiro) | Célula deve estar vazia e o jogo estar ativo (`running == true`). |
| **RF-04** | Áudio Sintetizado | P4.2, A1.4, E1.2 | N/A (Web Audio API) | Dispara frequências específicas para X, O, Vitória e Empate. |
| **RF-05** | Detecção de Vitória / Empate | P4.3, A1.1, E1.1 | UI-08 (Status do Jogo) | Valida as 8 matrizes vitoriosas (`winPatterns`) a cada movimento. |
| **RF-06** | Linha de Vitória e Confetes | A1.2, A1.3 | UI-10 (Linha) + Canvas Confetti | Calcula ângulo/distância entre células e dispara partículas na vitória. |
| **RF-07** | Placar e Transição de Rodada | A1.5, A1.7, E1.4 | UI-05, UI-06, UI-07 | Atualiza pontuação e limpa tabuleiro mantendo placar acumulado. |
| **RF-08** | Reinício Geral | A3.1, A3.2 | UI-11 (Botão Reiniciar) | Reseta matriz de dados, placar, rodadas e estilos de tela. |

---

## 18. Dicionário de Dados e Estrutura de Estado

| Variável / Propriedade | Tipo de Dado                    | Valor Padrão             | Descrição e Escopo de Uso                                                      |
| ----------------------- | ------------------------------- | ------------------------- | -------------------------------------------------------------------------------- |
| `options`             | Array de Strings (`Array(9)`) | `['', '', '', ..., '']` | Representa o estado lógico das 9 posições do tabuleiro.                       |
| `currentPlayer`       | String                          | `'X'`                   | Armazena o jogador do turno atual (`'X'` ou `'O'`).                          |
| `running`             | Boolean                         | `false` / `true`      | *Flag* que indica se o tabuleiro está ativo para receber cliques do usuário. |
| `winsX`               | Integer                         | `0`                     | Armazena a contagem de vitórias acumuladas do Jogador X.                        |
| `winsO`               | Integer                         | `0`                     | Armazena a contagem de vitórias acumuladas do Jogador O (ou CPU).               |
| `currentRound`        | Integer                         | `1`                     | Armazena o número da rodada atual na partida.                                   |
| `modeSelect`          | String                          | `'pvp'`                 | Configuração do modo de jogo (`'pvp'` ou `'cpu'`).                         |
| `formatSelect`        | String                          | `'single'`              | Configuração do formato da disputa (`'single'` ou `'bo3'`).                |

---

## 19. Critérios de Aceite (Para Avaliação do Professor)

* [ ] **CA-01 (Fidelidade Visual):** A aplicação utiliza a paleta de cores institucional da UNIFOR (`#003366`, `#0056b3`) e possui o subtítulo *"UNIVERSIDADE DE FORTALEZA"*.
* [ ] **CA-02 (Regra de Ocupação):** Não é possível sobrescrever uma célula que já possui o símbolo `'X'` ou `'O'`.
* [ ] **CA-03 (Bloqueio pós-Fim de Jogo):** Após uma vitória ou empate, o tabuleiro bloqueia cliques em células vazias até que a próxima rodada ou reinício aconteça.
* [ ] **CA-04 (Comportamento do Modo CPU):** Quando o modo "Contra o Computador" está selecionado, o sistema executa automaticamente a jogada do robô na vez do 'O' após uma breve pausa.
* [ ] **CA-05 (Regra do Melhor de 3):** No formato MD3, o jogo zera o tabuleiro entre rodadas e só encerra a partida completa se um jogador atingir 2 vitórias ou após o fim da 3ª rodada.
* [ ] **CA-06 (Efeitos Visuais de Vitória):** A linha contínua é traçada corretamente exatamente sobre as 3 células vitoriosas e os confetes são disparados na tela.
* [ ] **CA-07 (Autonomia de Áudio):** O sistema emite os efeitos sonoros sem depender de downloads ou arquivos `.mp3` externos.

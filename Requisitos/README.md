# Requisitos

Esta pasta concentra os artefatos de engenharia de requisitos utilizados no repositorio, desde modelos de apoio ate exemplos e documentos de visao da demanda.

## Objetivo

Organizar o processo de requisitos para garantir:

- clareza do que deve ser construido;
- padronizacao dos artefatos;
- melhor comunicacao entre time tecnico e partes interessadas.

## Estrutura da Pasta

- `Artefatos/`: materiais de apoio e modelos para elaboracao de documentos.
  - `Artefatos/Exemplos/`: exemplos prontos de visao, proposta, glossario, requisitos nao funcionais, casos de uso e regras de negocio.
  - `Artefatos/Templates/`: templates para criacao de novos artefatos (visao, glossario, CDU, RNF, RN).
- `Elicitacao/`: documentos de trabalho em andamento ou consolidados de elicitacao.
- `Especificação de Casos de Uso/`: guias e artefatos de especificação de CDU.
- `Especificação de Regra de Negocio/`: guia de elaboração e artefatos de RN.
- `Requisitos Não Funcionais/`: guia de elaboração de RNF.

## Como Usar

1. Comece pelos templates para criar um novo artefato.
2. Use os exemplos como referencia de preenchimento.
3. Registre os documentos finais ou evolutivos na estrutura apropriada.

## Exemplos Disponiveis

### Visão e Elicitação

- [Exemplo de visão da demanda para feira livre](Artefatos/Exemplos/exemplo-feira-livre-visao.md)
- [Exemplo de proposta para feira livre](Artefatos/Exemplos/PropostaFeiraLivre.md)
- [Exemplo de glossario para feira livre](Artefatos/Exemplos/glossario-feira-livre.md)

### Requisitos Não Funcionais

- [Exemplo de requisitos nao funcionais para feira livre](Artefatos/Exemplos/exemplo-requisitos-nao-funcionais-feira-livre.md)
- [Exemplo didático de requisitos nao funcionais para feira livre](Artefatos/Exemplos/exemplo-requisitos-nao-funcionais-feira-livre-didatico.md)

### Casos de Uso

- [Exemplo de CDU F1.1 Cadastro de feirante](Artefatos/Exemplos/exemplo-cdu-f1-1-cadastro-feirante.md)
- [Exemplo didático de CDU F1.1 Cadastro de feirante](Artefatos/Exemplos/exemplo-cdu-f1-1-cadastro-feirante-didatico.md)
- [Exemplo de CDU F1.3 Emissão de licença do feirante](Artefatos/Exemplos/exemplo-cdu-f1-3-emissao-licenca-feirante.md)

### Regras de Negócio

- [Exemplo de regras de negócio para cadastro e licença de feirante](Artefatos/Exemplos/exemplo-rn-cadastro-licenca-feirante.md)

## Guias Metodológicos

- [Documentando Requisitos com Caso de Uso](Especifica%C3%A7%C3%A3o%20de%20Casos%20de%20Uso/Casos%20de%20Usos.md) — Guia completo de elaboração de CDU com checklist
- [Documentando as Regras de Negócio da Solução](Especifica%C3%A7%C3%A3o%20de%20Regra%20de%20Negocio/EspecificacaoRegraNegocio.md) — Guia de especificação com checklist
- [Especificando Requisitos Não Funcionais](Requisitos%20N%C3%A3o%20Funcionais/Especificando%20Requisitos%20N%C3%A3o%20Funcionais.md) — Guia e template de RNF com checklist

## Templates Disponíveis

Localizados em `Artefatos/Templates/`:

- `template-visao-demanda.md` — Documento de Visão da Demanda
- `template-glossario.md` — Glossário de Termos
- `template-cdu-caso-uso.md` — Especificação de Caso de Uso com Checklist
- `template-requisitosNaoFuncionais.md` — Requisitos Não Funcionais com Checklist
- `template-rn-regra-negocio.md` — Regra de Negócio com Checklist

## Boas Praticas

- Mantenha nomenclatura consistente dos arquivos (exemplo: `exemplo-<tipo>-<tema>.md`);
- Atualize os históricos de versão sempre que houver mudança relevante;
- Use os templates como ponto de partida para novos artefatos;
- Consulte exemplos para entender padrões de preenchimento;
- Aplique checklists antes de finalizar documentos de requisitos;
- Preserve histórico e contexto dos requisitos para facilitar validação.

# Sistema IBGE Nomes Brasil - ![Badge](https://img.shields.io/static/v1?label=Status&message=Em%20Constru%C3%A7%C3%A3o&color=green&style=flat&logo=STATUS)

## Linguagens, dependências utilizadas

![Badge](https://img.shields.io/static/v1?label=ruby&message=3.0.0&color=red&style=for-the-badge&logo=RUBY)
![Badge](https://img.shields.io/static/v1?label=rspec&message=3.10&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=faraday&message=1.4.1&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=terminal%20table&message=3.0.0&color=red&style=for-the-badge)

## Descrição
Esse projeto consiste na recriação de um sistema de pesquisa de nomes utilizavel através do console, baseando-se no site do IBGE https://www.ibge.gov.br/censo2010/apps/nomes/#/search

## Funcionalidades

- Ranking dos nomes mais comuns em uma determinada Unidade Federativa (UF)
  - Tabela com ranking geral
  - Tabela com ranking a partir do gênero feminino
  - Tabela com ranking a partir do gênero masculino

- Ranking dos nomes mais comuns em uma determinada cidade
  - Tabela com ranking geral
  - Tabela com ranking a partir do gênero feminino
  - Tabela com ranking a partir do gênero masculino
- Frequência do uso de um nome ao longo dos anos

## Configuração

1. Copie o projeto para sua máquina

`git clone https://github.com/murilo-miranda/name_frequency.git`

2. Acesse a pasta do projeto

`cd name_frequency.git`

3. Instale as dependências

`bin/setup`

4. Inicie a aplicação

`ruby name_frequency.rb`
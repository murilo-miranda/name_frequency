# Sistema IBGE Nomes Brasil - ![Badge](https://img.shields.io/static/v1?label=Status&message=Em%20Constru%C3%A7%C3%A3o&color=green&style=flat&logo=STATUS)

## Linguagens, dependências utilizadas

![Badge](https://img.shields.io/static/v1?label=ruby&message=3.0.0&color=red&style=for-the-badge&logo=RUBY)
![Badge](https://img.shields.io/static/v1?label=rspec&message=3.10&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=faraday&message=1.4.1&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=terminal%20table&message=3.0.0&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=active%20record&message=ORM&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=standalone%20migrations&message=Migrations&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=bigdecimal&message=Precisão%20Float&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=pg&message=Conexão%20Banco&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=simplecov&message=Cobertura%20dos%20Testes&color=red&style=for-the-badge)


## Descrição
Aplicação utilizável a partir do terminal para a pesquisa de ranking iterativo dos nomes mais populares do Brasil, baseando-se no site do IBGE https://servicodados.ibge.gov.br/api/docs

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
  - Tabela com frequência a partir de um nome
  - Tabela com frequência a partir de dois nomes ou mais

## Configuração

1. Criar um usuário para a conexão

`sudo -u postgres createuser -s pguser`

2. Acessar o PostgreSQL console

`sudo -u postgres psql`

3. 'Setar' a senhar se que será utilizada para a conexão

`\password pguser`

4. Sair do PostgreSQL

`\q`

5. Copie o projeto para sua máquina

`git clone https://github.com/murilo-miranda/name_frequency.git`

6. Acesse a pasta do projeto

`cd name_frequency.git`

7. Instale as dependências

`bin/setup`

8. Inicie a aplicação

`ruby name_frequency.rb`

## APIS utilizadas

- API de Localidades: https://servicodados.ibge.gov.br/api/docs/localidades?versao=1
- API de Nomes: https://servicodados.ibge.gov.br/api/docs/censos/nomes?versao=2
- CSV com dados da população:
https://campus-code.s3-sa-east-1.amazonaws.com/treinadev/populacao_2019.csv
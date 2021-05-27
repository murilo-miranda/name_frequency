# frozen_string_literal: true

require 'spec_helper'
require 'system'
require 'faraday'
require_relative '../db/connection'
require_relative '../app/views/display'

describe 'Name Frequency System' do
  it 'user should receive welcome message when started' do
    expect { welcome }.to output("Bem-vindo ao sistema IBGE \n\n").to_stdout
  end

  it 'user should receive menu option list' do
    msg = <<~PUBLISHED
      Escolha a opção desejada:
      1. Listar nomes mais comuns de uma Unidade Federativa (UF)
      2. Listar nomes mais comuns de uma cidade
      3. Listar frequência de uso de um nome ao longo dos anos
      0. Sair \n
    PUBLISHED

    expect { menu }.to output(msg).to_stdout
  end

  it 'user should receive UF option list' do
    list = <<~PUBLISHED
      +---------------+---------------------+
      | IDENTIFICADOR | NOME                |
      +---------------+---------------------+
      | 12            | Acre                |
      | 27            | Alagoas             |
    PUBLISHED

    expect { uf_list_menu }.to output(include(list)).to_stdout
  end

  it 'user should receive name frequency over the years' do
    list = <<~PUBLISHED
      Digite o nome que deseja buscar - Não utilizar acento e separar os nomes por ','
      Por exemplo: murilo,joao
      +---------+--------+
      | Período | joao   |
      +---------+--------+
      | 1930    | 60155  |
      | 1940    | 141772 |
    PUBLISHED

    allow($stdin).to receive(:gets) { 'joao' }
    expect { frequency_list_menu }.to output(include(list)).to_stdout
  end

  it 'user should be asked for a city name' do
    msg = <<~PUBLISHED
      Digite o nome da cidade que deseja buscar
      Por exemplo: São Paulo, Alta Floresta D'Oeste
    PUBLISHED

    allow($stdin).to receive(:gets) { 'São Paulo' }
    expect { city_list_menu }.to output(include(msg)).to_stdout
  end
end

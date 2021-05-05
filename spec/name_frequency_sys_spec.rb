require 'spec_helper'
require 'name_frequency_sys'

describe 'Name Frequency System' do
  it 'user should receive welcome message when started' do
    expect {welcome}.to output("Bem-vindo ao sistema IBGE\n").to_stdout
  end

  it 'user should receive menu option list' do
    msg = <<~PUBLISHED
          Escolha a opção desejada:
          1. Listar nomes mais comuns de uma Unidade Federativa (UF)
          2. Listar nomes mais comuns de uma cidade
          3. Listar frequência de uso de um nome ao longo dos anos
          0. Sair
        PUBLISHED

    expect {menu}.to output(msg).to_stdout
  end

  it 'user should receive UF option list' do
    list = <<~PUBLISHED
          Lista das Unidades Federativas do Brasil
          11 - Rondônia - RO
          12 - Acre - AC
          13 - Amazonas - AM
          0. Voltar
        PUBLISHED

    expect {uf_list}.to output(list).to_stdout
  end

  xit 'user should receive the search result ' do
  end
end


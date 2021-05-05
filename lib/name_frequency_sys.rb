require 'terminal-table'

def welcome
  puts "Bem-vindo ao sistema IBGE \n\n"
end

def menu
  puts "Escolha a opção desejada:"
  puts "1. Listar nomes mais comuns de uma Unidade Federativa (UF)"
  puts "2. Listar nomes mais comuns de uma cidade"
  puts "3. Listar frequência de uso de um nome ao longo dos anos"
  puts "0. Sair \n\n"
end

def uf_list
  rows = []
  ufs = FederativeUnit.all

  puts "Lista das Unidades Federativas do Brasil \n\n"

  ufs.each do |uf|
    rows << [uf.id, uf.name]
  end

  puts Terminal::Table.new :headings => ['IDENTIFICADOR','NOME'], :rows => rows
  puts "\n"
  puts "Digite o identificador do UF desejado ou então 0 para voltar"
end
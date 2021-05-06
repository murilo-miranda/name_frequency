require 'terminal-table'
require_relative 'ranking_name'

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

def uf_list_menu
  rows = []
  ufs = FederativeUnit.all

  puts "Lista das Unidades Federativas do Brasil \n\n"

  ufs.each do |uf|
    rows << [uf.id, uf.name]
  end

  puts Terminal::Table.new :headings => ['IDENTIFICADOR','NOME'], :rows => rows
  puts "\n"
  puts "Digite o identificador do UF desejado ou então 0 para voltar"
  option = gets.to_i

  loop do
    case option
    when /\D/
      puts 'A informação que inseriu não é um número, por favor insira um identificador válido'
    when 11..53
      people = RankingName.find(option)
      rows = []

      people.each do |person|
        rows << [person.rank, person.name, person.frequency]
      end

      puts Terminal::Table.new :headings => ['Rank', 'Nome', 'Frequencia'], :rows => rows
      break
    when 0
      puts 'Voltando'
      break
    end

    option = gets.to_i
  end
end

def frequency_list_menu
  puts 'Digite o nome que deseja buscar:'
  name = gets.chomp
  rank_years = RankingName.find_by(name)

  rows = []
  rank_years.each do |ry|
    rows << [ry.rank, ry.frequency]
  end

  puts Terminal::Table.new :headings => ['Periodo', "#{name}"], :rows => rows
end
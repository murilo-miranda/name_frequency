require 'terminal-table'
require 'byebug'
require_relative 'ranking_name'
require_relative '../app/models/federative_unit'

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
  list_uf

  puts "Digite o identificador do UF desejado ou então 0 para voltar"
  option = gets.to_i

  loop do
    case option
    when /\D/
      puts 'A informação que inseriu não é um número, por favor insira um identificador válido'
    when 11..53
      result = RankingName.find(option)
      rows = []

      result.each do |people|
        people.each do |person|
          rows << [person.rank, person.name, person.frequency]
        end
        puts Terminal::Table.new :headings => ['Rank', 'Nome', 'Frequencia'], :rows => rows
        rows.clear
      end
      break
    when 0
      puts 'Voltando'
      break
    end

    option = gets.to_i
  end
end

def city_list_menu
  puts 'Digite o nome da cidade que deseja buscar'
end

def frequency_list_menu
  puts "Digite o nome que deseja buscar - Não utilizar acento e separar os nomes por ','"
  puts 'Por exemplo: murilo,joao'

  name = STDIN.gets.chomp
  rank_years = RankingName.find_by_name(name)

  rows = []
  data_row = []

  rank_years.first.size.times do |year|
    data_row << rank_years[0][year].rank
    rank_years.each do |person|
      data_row << person[year].frequency
    end

    rows << data_row
    data_row = []
  end

  header = []
  header = name.split(',').sort
  puts Terminal::Table.new :headings => ['Período'].concat(header), :rows => rows
end

def list_uf
  rows = []
  ufs = FederativeUnit.all

  puts "Lista das Unidades Federativas do Brasil \n\n"

  ufs.each do |uf|
    rows << [uf.code, uf.name]
  end

  puts Terminal::Table.new :headings => ['IDENTIFICADOR','NOME'], :rows => rows
  puts "\n"
end

def list_city(code)
  rows = []
  cities = FederativeUnit.find_cities(code)

  puts "Lista das cidades \n\n"

  cities.each do |city|
    rows << [uf.id, uf.name]
  end

  puts Terminal::Table.new :headings => ['IDENTIFICADOR','NOME'], :rows => rows
  puts "\n"
end
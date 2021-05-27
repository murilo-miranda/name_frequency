require 'terminal-table'
require 'byebug'
require_relative 'ranking_name'
require_relative '../app/models/federative_unit'
require_relative '../app/models/city'
require_relative '../app/services/tablehandler'

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
      federative_unit = FederativeUnit.where(code: option)
      population = federative_unit.first.population

      result.each do |people|
        rows = people.map do |person|
          percentage = person.frequency / population.to_f * 100
          [person.rank, person.name, person.frequency, percentage.floor(1)]
        end

        puts TableHandler.create_table(%w[Rank Nome Frequencia Percentual], rows)

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
  puts "Por exemplo: São Paulo, Alta Floresta D'Oeste"
  city_name = $stdin.gets.chomp
  list_city(city_name)
end

def frequency_list_menu
  puts "Digite o nome que deseja buscar - Não utilizar acento e separar os nomes por ','"
  puts 'Por exemplo: murilo,joao'

  name = $stdin.gets.chomp
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

  header = name.split(',').sort

  puts TableHandler.create_table(['Período'].concat(header), rows)
end

def list_uf
  ufs = FederativeUnit.all

  rows = ufs.map do |uf|
    [uf.code, uf.name]
  end

  puts TableHandler.create_table(%w[IDENTIFICADOR NOME], rows)
  puts "\n"
end

def list_city(city_name)
  city = City.where(name: city_name)

  if city.first.nil?
    puts "\n\n"
    puts 'Nome da cidade não encontrado, certifique-se de que escreveu corretamente'
    puts "\n\n"
    city_list_menu
  end

  result = RankingName.find(city.first.code)
  population = city.first.population
  rows = []

  result.each do |people|
    rows = people.map do |person|
      percentage = person.frequency / population.to_f * 100
      [person.rank, person.name, person.frequency, percentage.floor(1)]
    end

    puts TableHandler.create_table(%w[Rank Nome Frequencia Percentual], rows)
    rows.clear
  end
end

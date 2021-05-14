require 'active_record'
require 'faraday'
require 'csv'
require 'byebug'
require_relative '../app/models/federative_unit'
require_relative '../app/models/city'
require_relative 'connection'

### Populate database

p 'Fazendo conexões'
fus = Faraday.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome')
cities = Faraday.get('https://servicodados.ibge.gov.br/api/v1/localidades/municipios')

p 'Preparando os dados'
fus_json = JSON.parse(fus.body, symbolize_names:true)
cities_json = JSON.parse(cities.body, symbolize_names:true)
table = CSV.parse(File.read("spec/support/populacao_2019.csv"), headers: true)
table_ufs = table.select {|element| element.to_s.start_with?('UF')}

p 'Salvando no banco'
fus_json.each do |fu|
  population = table_ufs.select {|row| row['Cód.'] == fu[:id].to_s}
  FederativeUnit.create(code: fu[:id], name: fu[:nome], population: population.first['População Residente - 2019'])
end

cities_json.each do |city|
  population = table.select {|row| row['Cód.'] == city[:id].to_s}
  City.create(code: city[:id], name: city[:nome], population: population.first['População Residente - 2019'])
end
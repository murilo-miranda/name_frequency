require 'active_record'
require 'faraday'
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

p 'Salvando no banco'
fus_json.each do |fu|
  FederativeUnit.create(code: fu[:id], name: fu[:nome])
end

cities_json.each do |fu|
  City.create(code: fu[:id], name: fu[:nome])
end
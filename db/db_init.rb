require 'active_record'
require 'faraday'
require_relative '../app/models/federative_unit'
require_relative 'connection'

### Populate database

p 'Get faraday'
response = Faraday.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome')

p 'Formatting json'
fu_json = JSON.parse(response.body, symbolize_names:true)

p 'Start loop'
fu_json.each do |fu|
  federative_unit = FederativeUnit.new(code: fu[:id], name: fu[:nome])
  federative_unit.save!
  p "Created: #{federative_unit}"
end
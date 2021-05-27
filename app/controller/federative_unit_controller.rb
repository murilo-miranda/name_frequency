require 'faraday'
require 'json'
require_relative '../app/models/federative_unit'

class FederativeUnitController
  def create
    response = Faraday.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome')

    json = JSON.parse(response.body, symbolize_names: true)
    json.map do |uf|
      fu = FederativeUnit.new(code: uf[:id], name: uf[:nome])
      fu.save!
    end
  end

  def self.find_cities(code)
    response = Faraday.get("https://servicodados.ibge.gov.br/api/v1/localidades/estados/#{code}/municipios")

    json = JSON.parse(response.body, symbolize_names: true)
    json.map do |uf|
      new(code: uf[:id], name: uf[:nome])
    end
  end
end

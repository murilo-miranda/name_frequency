require 'faraday'
require 'json'

class FederativeUnit
  attr_reader :code, :name

  def initialize(code:, name:)
    @code = code
    @name = name
  end

  def self.all
    response = Faraday.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome')

    json = JSON.parse(response.body, symbolize_names:true)
    result = json.map do |uf|
      new(code: uf[:id], name: uf[:nome])
    end

    return result
  end

  def self.find_cities(code)
    response = Faraday.get("https://servicodados.ibge.gov.br/api/v1/localidades/estados/#{code}/municipios")

    json = JSON.parse(response.body, symbolize_names:true)
    result = json.map do |uf|
      new(code: uf[:id], name: uf[:nome])
    end

    return result
  end
end
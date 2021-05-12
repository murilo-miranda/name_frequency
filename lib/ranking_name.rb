require 'faraday'
require 'json'
require 'byebug'

class RankingName
  attr_reader :rank, :name, :frequency

  def initialize(rank:, name:, frequency:)
    @rank = rank
    @name = name
    @frequency = frequency
  end

  def self.find(uf)
    result = []
    gender = ['M', 'F']

    response = Faraday.get("https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf}")
    result << processes_response(response)

    gender.each do |g|
      response = Faraday.get("https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf}&sexo=#{g}")
      result << processes_response(response)
    end

    return result
  end

  def self.find_by_name(name)
    tables = []
    result = []
    name = name.gsub(',','%7C')

    response = Faraday.get("https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{name}")

    json = JSON.parse(response.body, symbolize_names:true)

    json.each do |person|
      name = person[:name]
      person[:res].each do |p|
        result << new(rank: p[:periodo][-5..-2], name: name, frequency: p[:frequencia])
      end
      tables << result
      result = []
    end

    return tables
  end

  def self.find_by_city(code)
    response = Faraday.get("https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{code}")
    processes_response(response)
  end

  def self.processes_response(response)
    json = JSON.parse(response.body, symbolize_names:true)
    result = json.first[:res].map do |person|
      new(rank: person[:ranking], frequency: person[:frequencia], name: person[:nome])
    end
    return result
  end
end
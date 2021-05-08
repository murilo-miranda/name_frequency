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

  def self.find_by(name)
    response = Faraday.get("https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{name}")
    json = JSON.parse(response.body, symbolize_names:true)
    result = json.first[:res].map do |person|
      new(rank: person[:periodo][-5..-2], name: person[:nome], frequency: person[:frequencia])
    end

    return result
  end

  def self.processes_response(response)
    json = JSON.parse(response.body, symbolize_names:true)
    result = json.first[:res].map do |person|
      new(rank: person[:ranking], frequency: person[:frequencia], name: person[:nome])
    end
    return result
  end
end
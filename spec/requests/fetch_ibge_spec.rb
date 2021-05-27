# frozen_string_literal: true

require 'spec_helper'
require 'faraday'
require_relative '../../app/models/federative_unit'
require_relative '../../db/connection'

describe 'Fetch data - UF' do
  context 'Get UFs' do
    it 'should get Ufs information' do
      json_response = File.read('spec/support/api/ufs_info.json')
      url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      ufs = FederativeUnit.all

      expect(ufs[0].name).to eq('Acre')
      expect(ufs[1].name).to eq('Alagoas')
      expect(ufs[2].name).to eq('Amapá')
    end
  end

  context 'Get common name from UFs' do
    it 'should get ranking name' do
      json_response = File.read('spec/support/api/ranking_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=12'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      response = Faraday.get(url)
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[0][:res][0][:nome]).to eq('MARIA')
      expect(json_response[0][:res][1][:nome]).to eq('JOSE')
    end
  end

  context 'Get common male name from UFs' do
    it 'should get ranking male name' do
      json_response = File.read('spec/support/api/ranking_male_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=12&sexo=M'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      response = Faraday.get(url)
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[0][:res][0][:nome]).to eq('JOSE')
      expect(json_response[0][:res][1][:nome]).to eq('FRANCISCO')
    end
  end

  context 'Get common female name from UFs' do
    it 'should get ranking female name' do
      json_response = File.read('spec/support/api/ranking_female_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=12&sexo=F'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      response = Faraday.get(url)
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[0][:res][0][:nome]).to eq('MARIA')
      expect(json_response[0][:res][1][:nome]).to eq('ANA')
    end
  end

  context 'Get frequency name over the years' do
    it 'should get frequency by name' do
      json_response = File.read('spec/support/api/frequency_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      frequency = RankingName.find_by_name('joao')

      expect(frequency[0][0].frequency).to eq(601_55)
      expect(frequency[0][0].rank).to eq('1930')
      expect(frequency[0][1].frequency).to eq(141_772)
      expect(frequency[0][1].rank).to eq('1940')
    end
  end

  context 'Get commom name by city' do
    it 'should get ranking name by city' do
      json_response = File.read('spec/support/api/rank_names_city.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=1200013'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      frequency = RankingName.find_by_city(120_001_3)

      expect(frequency[0].name).to eq('MARIA')
      expect(frequency[0].frequency).to eq(713)
      expect(frequency[1].name).to eq('JOSE')
      expect(frequency[1].frequency).to eq(422)
    end
  end
end

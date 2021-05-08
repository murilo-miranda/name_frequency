require 'spec_helper.rb'
require 'faraday'

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

  xcontext 'Get common name from UFs' do
    it 'should get ranking name' do
      json_response = File.read('spec/support/api/ranking_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=12'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      rank = RankingName.find('12')

      expect(rank[0].name).to eq('MARIA')
      expect(rank[1].name).to eq('JOSE')
    end
  end

  xcontext 'Get common male name from UFs' do
    it 'should get ranking male name' do
      json_response = File.read('spec/support/api/ranking_male_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=12&sexo=M'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)
    end
  end

  context 'Get frequency name over the years' do
    it 'should get frequency by name' do
      json_response = File.read('spec/support/api/frequency_names.json')
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao'
      faraday_response = double('faraday_response', body: json_response, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(faraday_response)

      frequency = RankingName.find_by('joao')

      expect(frequency[0].frequency).to eq(60155)
      expect(frequency[0].rank).to eq('1930')
      expect(frequency[1].frequency).to eq(141772)
      expect(frequency[1].rank).to eq('1940')
    end
  end
end
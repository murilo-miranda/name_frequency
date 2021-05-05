require 'spec_helper.rb'
require 'faraday'

describe 'Fetch data' do
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
end
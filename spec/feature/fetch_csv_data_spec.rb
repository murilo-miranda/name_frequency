require 'spec_helper.rb'
require 'csv'

describe 'Fetch csv data' do
  context 'read csv file' do
    it 'should get all data' do
      table = CSV.parse(File.read("spec/support/populacao_2019.csv"), headers: true)

      expect(table[0]['Nível']).to eq 'UF'
      expect(table[0]['Cód.']).to eq '11'
      expect(table[0]['Unidade da Federação']).to eq 'Rondônia'
      expect(table[0]['População Residente - 2019']).to eq '1777225'
    end

    it 'should search for UF data' do
      table = CSV.parse(File.read("spec/support/populacao_2019.csv"), headers: true)

      table_ufs = table.select {|element| element.to_s.start_with?('UF')}

      expect(table_ufs.first['Nível']).to eq 'UF'
      expect(table_ufs.first['Cód.']).to eq '11'
      expect(table_ufs.first['Unidade da Federação']).to eq 'Rondônia'
      expect(table_ufs.first['População Residente - 2019']).to eq '1777225'
      expect(table_ufs.last['Nível']).to eq 'UF'
      expect(table_ufs.last['Cód.']).to eq '53'
      expect(table_ufs.last['Unidade da Federação']).to eq 'Distrito Federal'
      expect(table_ufs.last['População Residente - 2019']).to eq '3015268'
    end

    it 'should search for MU data' do
      table = CSV.parse(File.read("spec/support/populacao_2019.csv"), headers: true)

      table_ufs = table.select {|element| element.to_s.start_with?('UF')}
      pos = table_ufs.count

      table[pos..30].each do |city|
        expect(city['Nível']).to eq 'MU'
        expect(city['Cód.']).to eq city['Cód.']
        expect(city['Unidade da Federação']).to eq city['Unidade da Federação']
        expect(city['População Residente - 2019']).to eq city['População Residente - 2019']
      end
    end
  end
end
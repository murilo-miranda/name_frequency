class AddPopulationToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :population, :string, null: false
  end
end

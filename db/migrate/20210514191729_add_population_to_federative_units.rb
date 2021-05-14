class AddPopulationToFederativeUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :federative_units, :population, :string, null: false
  end
end

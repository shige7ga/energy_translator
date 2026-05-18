class CreateEnergyUnits < ActiveRecord::Migration[7.2]
  def change
    create_table :energy_units do |t|
      t.string :name, null: false
      t.float :to_joule, null: false # J換算(例：1kcal = 4184J)
      t.text :description
      t.text :formula_text
      t.string :reference_url

      t.timestamps
    end
  end
end

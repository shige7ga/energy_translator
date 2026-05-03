class CreateConversions < ActiveRecord::Migration[7.2]
  def change
    create_table :conversions do |t|
      t.string :name, null: false
      t.text :description
      t.string :category, null: false
      t.string :input_unit, null: false, default: "kcal"
      t.string :output_unit, null: false
      t.decimal :factor, precision: 10, scale: 4, null: false
      t.integer :calculation_type, null: false, default: 0
      t.string :reference_url
      t.string :icon

      t.timestamps
    end
  end
end

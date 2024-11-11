# db/migrate/20241109123456_create_inflation_adjustments.rb
class CreateInflationAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :inflation_adjustments do |t|
      t.references :sip_investment, null: false, foreign_key: true
      t.decimal :annual_rate, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end

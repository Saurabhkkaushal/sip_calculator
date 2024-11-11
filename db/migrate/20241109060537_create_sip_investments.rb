class CreateSipInvestments < ActiveRecord::Migration[8.0]
  def change
    create_table :sip_investments do |t|
      t.decimal :principal
      t.decimal :rate_of_return
      t.decimal :yearly_step_up_percentage
      t.integer :duration

      t.timestamps
    end
  end
end

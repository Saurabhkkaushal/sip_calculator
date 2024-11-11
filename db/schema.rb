# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_11_09_061247) do
  create_table "inflation_adjustments", force: :cascade do |t|
    t.integer "sip_investment_id", null: false
    t.decimal "annual_rate", precision: 5, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sip_investment_id"], name: "index_inflation_adjustments_on_sip_investment_id"
  end

  create_table "sip_investments", force: :cascade do |t|
    t.decimal "principal"
    t.decimal "rate_of_return"
    t.decimal "yearly_step_up_percentage"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inflation_adjustments", "sip_investments"
end

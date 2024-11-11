class InflationAdjustment < ApplicationRecord
  belongs_to :sip_investment

  validates :annual_rate, numericality: { greater_than: 3, less_than: 10, message: "should be between 3% and 10%" }, on: :create
end
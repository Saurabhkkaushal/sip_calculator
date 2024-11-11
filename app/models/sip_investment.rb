# app/models/sip_investment.rb
class SipInvestment < ApplicationRecord
  has_one :inflation_adjustment

  # Validation for monthly contribution
  validates :principal, numericality: { greater_than: 0, less_than_or_equal_to: 500000, message: "should be between 1 and 5,00,000" }

  # Validation for rate of return
  validates :rate_of_return, numericality: { greater_than: 0, less_than_or_equal_to: 30, message: "should be between 1 and 30%" }

  # Validation for duration
  validates :duration, numericality: { greater_than: 0, less_than_or_equal_to: 40, message: "should be between 1 and 40 years" }

  # Validation for inflation adjustment annual rate
  validates :inflation_adjustment, presence: true
  validates_associated :inflation_adjustment

  # Validation for yearly step-up percentage
  validates :yearly_step_up_percentage, numericality: { less_than_or_equal_to: 50, message: "should be less than or equal to 50%" }

  accepts_nested_attributes_for :inflation_adjustment

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.principal ||= 10000  # Monthly Contribution default to 10000
    self.rate_of_return ||= 12  # Annual Rate of Return default to 12%
    self.duration ||= 10  # Investment Duration default to 10 years
    self.yearly_step_up_percentage ||= 10  # Yearly Step-Up default to 10%
    self.inflation_adjustment ||= InflationAdjustment.new(annual_rate: 6)  # Inflation Rate default to 6%
  end

  def calculate_return
    total_return = 0
    monthly_contribution = principal
    annual_rate = rate_of_return / 100.0
    inflation_rate = inflation_adjustment&.annual_rate.to_f / 100.0
    months = duration * 12
    yearly_step_up_rate = yearly_step_up_percentage / 100.0

    # Calculate monthly rate
    monthly_rate = annual_rate / 12

    months.times do |month|
      # Determine the current year
      year = (month / 12).to_i

      # Apply the step-up each year
      if year > 0 && month % 12 == 0
        monthly_contribution *= (1 + yearly_step_up_rate)
      end

      # Apply inflation adjustment monthly
      adjusted_contribution = monthly_contribution * ((1 + inflation_rate) ** (month / 12))

      # Apply the compounded return for this month
      compounded_rate = (1 + monthly_rate) ** (month + 1)
      total_return += adjusted_contribution * compounded_rate
    end

    total_return.to_i  # Return as an integer
  end

  def total_return_in_words
    ApplicationController.helpers.number_to_indian_words(calculate_return)
  end
end

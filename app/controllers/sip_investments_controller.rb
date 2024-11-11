class SipInvestmentsController < ApplicationController
  def new
    @sip_investment = SipInvestment.new(
      principal: 10000,
      rate_of_return: 12,
      duration: 10,
      inflation_adjustment_attributes: { annual_rate: 6 },
      yearly_step_up_percentage: 10 # Default to 10% yearly step-up
    )
  end

  def create
    @sip_investment = SipInvestment.new(sip_investment_params)

    if @sip_investment.valid?
      @calculated_return = @sip_investment.calculate_return
      render :new  # Stay on the same page to display results
    else
      render :new  # If validation fails, stay on the form
    end
  end

  private

  def sip_investment_params
    params.require(:sip_investment).permit(
      :principal, :rate_of_return, :duration, :yearly_step_up_percentage,
      inflation_adjustment_attributes: [:annual_rate]
    )
  end
end

# app/helpers/application_helper.rb
module ApplicationHelper
  def number_to_indian_words(number)
    units = ['', 'thousand', 'lakh', 'crore']
    words = []
    remainder = number

    # Split the number according to the Indian numbering system
    [10000000, 100000, 1000, 1].each_with_index do |value, index|
      quotient, remainder = remainder.divmod(value)
      if quotient > 0
        words << "#{quotient} #{units[3 - index]}"
      end
    end

    words.join(' ').strip
  end
end

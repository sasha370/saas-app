class Payment < ActiveRecord::Base

  # Принадлежит Организации
  belongs_to :tenant
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year

  # Метод для формирования списка месяцев в форме
  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name,i| ["#{i+1} - #{name}", i+1] }
  end

  # Метод для формиравания списка годов для отображения в форме
  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end


  def process_payment
    # Создать покупателя по email и token
    customer = Stripe::Customer.create email: email, source: token


    Stripe::Charge.create customer: customer.id,
                          amount: 1000,
                          description: 'premium',
                          currency: 'usd'

  end
end

# Returns an array with two integers, which are the indexes of the best day to buy and the best day to sell, respectively.
def stock_picker(stock_prices)
  deals = []

  stock_prices.size.times do |day_to_buy|
    stock_prices.size.times do |day_to_sell|
      next unless day_to_buy < day_to_sell
      deals << Deal.new(day_to_buy, day_to_sell, stock_prices)
    end
  end
  deals.max.to_a
end

class Deal
  attr_reader :day_to_buy, :day_to_sell
  
  def initialize(day_to_buy, day_to_sell, stock_prices)
    @day_to_buy, @day_to_sell, @stock_prices = day_to_buy, day_to_sell, stock_prices
  end

  def profit
    @stock_prices[@day_to_sell] - @stock_prices[@day_to_buy]
  end

  def <=>(other_deal) 
    profit <=> other_deal.profit
  end

  def to_a
    [@day_to_buy, @day_to_sell]
  end
end

stock_prices = [17,3,6,9,15,8,6,1,10]
p stock_prices
p stock_picker(stock_prices)

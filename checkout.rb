class Checkout
  attr_reader :items
  def initialize(promotional_rules = [])
    @items = []
    @promotional_rules = promotional_rules
    @total = 0
  end

  def scan(item)
    @items << item
  end

  def total
    @items.each do |item|
      @total += item[:price_cents]
    end
    check_promotions
    return (@total / 100.0).round(2)
  end

  def handle_price_drop(rule)
    products_discounted = @items.select do |item|
      item[:product_code] == rule[:product_code]
    end

    if products_discounted.count >= rule[:minimum_items]
      products_discounted.count.times do
        @total -= products_discounted.first[:price_cents]
        @total += rule[:price_cents]
      end
    end
  end

  def handle_percentage(rule)
    if @total >= rule[:minimum_cents]
      @total = @total * (1 - rule[:amount_of_discount])
    end
  end

  def check_promotions
    @promotional_rules.each do |rule|
      if rule[:type] == :price_drop
        handle_price_drop(rule)
      elsif rule[:type] == :percentage
        handle_percentage(rule)
      else
        puts "Unknown type of promotion"
      end
    end
  end
end


require_relative "../checkout"

PRODUCTS = [
  {product_code: 001, name: "Very Cheap Chair", price: 9.25},
  {product_code: 002, name: "Little table", price: 45.00},
  {product_code: 003, name: "Funky light", price: 19.95},
]

PROMO = [
  {type: :percentage, amount: 10, minimum: 60},
  {type: :price_drop, price: 8.5, product_code: 001, minimum: 2}
]

describe "Checkout" do

  describe "#scan" do
    it "should add the item to the cart" do
      co = Checkout.new
      product = PRODUCTS[1]
      scanned = co.scan(product)
      expect(co.items.count).to eq(1)
    end
  end

  describe "#total" do
    it "should total £0 if the basket is empty" do
      co = Checkout.new(PROMOS)
      expect(co.total).to eq(0)
    end

    it "should total £66.78 for the basket: 001, 002, 003" do
      co = Checkout.new
      scanned = co.scan(PRODUCTS[0])
      scanned = co.scan(PRODUCTS[1])
      scanned = co.scan(PRODUCTS[2])
      expect(co.total).to eq(66.78)
    end

    it "should total £36.95 for the basket: 001, 003, 001 " do
      co = Checkout.new
      scanned = co.scan(PRODUCTS[0])
      scanned = co.scan(PRODUCTS[2])
      scanned = co.scan(PRODUCTS[0])
      expect(co.total).to eq(36.95)
    end

    it "should total £73.76 for the basket: 001, 002, 001, 003 " do
      co = Checkout.new
      scanned = co.scan(PRODUCTS[0])
      scanned = co.scan(PRODUCTS[1])
      scanned = co.scan(PRODUCTS[0])
      scanned = co.scan(PRODUCTS[2])
      expect(co.total).to eq(73.76)
    end
  end
end

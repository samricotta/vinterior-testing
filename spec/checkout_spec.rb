require_relative "checkout"

PRODUCTS = [
  {product_code: 001, name: "Very Cheap Chair", price: 9.25},
  {product_code: 002, name: "Little table", price: 45.00},
  {product_code: 003, name: "Funky light", price: 19.95}
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
    it "should total £66.78 for the basket: 001, 002, 003" do
      co = Checkout.new
      expect().to eq()
    end
  end
end

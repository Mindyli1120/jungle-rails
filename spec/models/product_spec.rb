require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    it "should be valid with valid attributes" do
      @category = Category.new(name: 'bags')
      @category.save!
      @product = @category.products.create(name: 'stunning purple bag', price: 3000, quantity: 100, category: @category)
      @product.save
      expect(@product).to be_valid
    end
    it "should not be valid without name" do
      @category = Category.new(name: 'shoes')
      @category.save!
      @product = @category.products.create(name: nil, price: 3000, quantity: 100, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "should not be valid without price" do
      @category = Category.new(name: 'shoes')
      @category.save!
      @product = @category.products.create(name: 'white sneaker', price: nil, quantity: 100, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end
    it "should not be valid without quantity" do
      @category = Category.new(name: 'shoes')
      @category.save!
      @product = @category.products.create(name: 'white sneaker', price: 3000, quantity: nil, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "should not be valid without category" do
      @product = Product.new(name: 'white sneaker', price: 3000, quantity: 100, category: nil)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

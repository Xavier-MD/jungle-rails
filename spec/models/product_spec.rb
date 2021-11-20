require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    #Valid product condition
    it "should evaluate to true if all 4 product fields are filled out" do
      @category = Category.new
      @product = Product.new
      @category.name = 'Furniture'
      @product.name = 'Couch'
      @product.price_cents = 231.99
      @product.quantity = 18
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to_not be_present
    end

    #Invalid product condition (@product.name = nil)
    it "should receive an error if the name field is equal to nil" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Furniture'
      @product.name = nil
      @product.price_cents = 231.99
      @product.quantity = 18
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to be_present
    end

    #Invalid product condition (@product.price_cents = nil)
    it "should receive an error if the price_cents field is equal to nil" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Furniture'
      @product.name = 'Couch'
      @product.price_cents = nil
      @product.quantity = 18
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to be_present
    end

    #Invalid product condition (@product.quantity = nil)
    it "should receive an error if the quantity field is equal to nil" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Furniture'
      @product.name = 'Couch'
      @product.price_cents = 231.99
      @product.quantity = nil
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to be_present
    end

    #Invalid product condition (@product.category = nil)
    it "should receive an error if the category field is equal to nil" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Furniture'
      @product.name = 'Couch'
      @product.price_cents = 231.99
      @product.quantity = 18
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to be_present
    end

  end
end


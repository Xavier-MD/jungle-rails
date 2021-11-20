require 'rails_helper'

RSpec.feature "Visitor navigates to cart page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see that a product has been placed into the cart" do
    # ACT
    visit root_path
    expect(page).to have_text('My Cart (0)')
    first('article.product').find_button('Add').click

    # VERIFY
    expect(page).to have_text('My Cart (1)')

    # DEBUG
    page.save_screenshot
  end
end 
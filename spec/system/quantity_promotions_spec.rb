# frozen_string_literal: true

require 'solidus_starter_frontend_spec_helper'

RSpec.describe 'Quantity Promotions', type: :system, js: true do
  let(:action) do
    Spree::Promotion::Actions::CreateQuantityAdjustments.create(
      calculator: calculator,
      preferred_group_size: 2
    )
  end

  let(:promotion) { FactoryBot.create(:promotion, code: 'PROMO') }
  let(:calculator) { FactoryBot.create(:calculator, preferred_amount: 5) }

  before do
    create(:store)
    FactoryBot.create(:product_in_stock, name: "DL-44")
    FactoryBot.create(:product_in_stock, name: "E-11")
    promotion.actions << action

    visit products_path
    click_link "DL-44"
    click_button "Ajouter au panier"
  end

  it 'adding and removing items from the cart' do
    # Attempt to use the code with too few items.
    fill_in "coupon_code", with: "PROMO"
    click_button "Appliquer le code"
    expect(page).to have_content("This coupon code could not be applied to the cart at this time")

    # Add another item to our cart.
    visit products_path
    click_link "DL-44"
    click_button "Ajouter au panier"

    # Using the code should now succeed.
    fill_in "coupon_code", with: "PROMO"
    click_button "Appliquer le code"
    expect(page).to have_content("The coupon code was successfully applied to your order")
    within("#cart_adjustments") do
      expect(page).to have_content("-$10.00")
    end

    # Reduce quantity by 1, making promotion not apply.
    select "1", from: "order_line_items_attributes_0_quantity"
    click_button "Update"
    expect(page).to_not have_content("#cart_adjustments")

    # Bump quantity to 3, making promotion apply "once."
    select "3", from: "order_line_items_attributes_0_quantity"
    click_button "Update"
    within("#cart_adjustments") do
      expect(page).to have_content("-$10.00")
    end

    # Bump quantity to 4, making promotion apply "twice."
    select "4", from: "order_line_items_attributes_0_quantity"
    click_button "Update"
    within("#cart_adjustments") do
      expect(page).to have_content("-$20.00")
    end
  end

  # Catches an earlier issue with quantity calculation.
  it 'adding odd numbers of items to the cart' do
    # Bump quantity to 3
    select "3", from: "order_line_items_attributes_0_quantity"
    click_button "Update"

    # Apply the promo code and see a $10 discount (for 2 of the 3 items)
    fill_in "coupon_code", with: "PROMO"
    click_button "Appliquer le code"
    expect(page).to have_content("The coupon code was successfully applied to your order")
    within("#cart_adjustments") do
      expect(page).to have_content("-$10.00")
    end

    # Add a different product to our cart with quantity of 2.
    visit products_path
    click_link "E-11"
    select "2", from: "quantity"
    click_button "Ajouter au panier"

    # We now have 5 items total, so discount should increase.
    within("#cart_adjustments") do
      expect(page).to have_content("-$20.00")
    end
  end

  context "with a group size of 3" do
    let(:action) do
      Spree::Promotion::Actions::CreateQuantityAdjustments.create(
        calculator: calculator,
        preferred_group_size: 3
      )
    end

    before { FactoryBot.create(:product, name: 'DC-15A') }

    it 'odd number of changes to quantities' do
      select "3", from: "order_line_items_attributes_0_quantity"
      click_button "Update"

      # Apply the promo code and see a $15 discount
      fill_in "coupon_code", with: "PROMO"
      click_button "Appliquer le code"
      expect(page).to have_content("The coupon code was successfully applied to your order")
      within("#cart_adjustments") do
        expect(page).to have_content("-$15.00")
      end

      # Add two different products to our cart
      visit products_path
      click_link "E-11"
      click_button "Ajouter au panier"
      within("#cart_adjustments") do
        expect(page).to have_content("-$15.00")
      end

      # Reduce quantity of first item to 2
      select "2", from: "order_line_items_attributes_0_quantity"
      click_button "Update"
      within("#cart_adjustments") do
        expect(page).to have_content("-$15.00")
      end
    end
  end
end

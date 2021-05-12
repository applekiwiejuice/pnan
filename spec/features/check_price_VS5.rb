require 'rails_helper'

RSpec.describe 'Check VS5 price', type: :feature do

  before do
    visit root_path
    click_link 'Add Products'
    click_link 'New Item'

    within 'form' do
      fill_in "item_item_name", with: "Vegemite Scroll"
      fill_in "item_item_code", with: "VS5"
      click_button 'New item'
    end

    click_link 'Back'
    click_link 'Add Packs'
    click_link 'New Pack'

    within 'form' do
      fill_in "pack_quantity", with: 3
      fill_in "pack_price", with: 6.99
      click_button 'New pack'
    end

    visit root_path
  end

  it 'Check 10 VS5 if equal to 17.98' do

    within('#VS5') do
      fill_in "quantity", with: 10
      click_button 'Get Price'
    end

    expect(page).to have_content("$17.98")
  end

end
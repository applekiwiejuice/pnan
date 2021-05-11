require 'rails_helper'

RSpec.describe "items/show", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      item_name: "Item Name",
      item_code: "Item Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Item Name/)
    expect(rendered).to match(/Item Code/)
  end
end

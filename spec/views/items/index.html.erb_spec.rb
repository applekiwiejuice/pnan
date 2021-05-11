require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        item_name: "Item Name",
        item_code: "Item Code"
      ),
      Item.create!(
        item_name: "Item Name",
        item_code: "Item Code"
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", text: "Item Name".to_s, count: 2
    assert_select "tr>td", text: "Item Code".to_s, count: 2
  end
end

require 'rails_helper'

RSpec.describe "packs/new", type: :view do
  before(:each) do
    assign(:pack, Pack.new())
  end

  it "renders new pack form" do
    render

    assert_select "form[action=?][method=?]", packs_path, "post" do
    end
  end
end

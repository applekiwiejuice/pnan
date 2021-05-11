require 'rails_helper'

RSpec.describe "packs/edit", type: :view do
  before(:each) do
    @pack = assign(:pack, Pack.create!())
  end

  it "renders the edit pack form" do
    render

    assert_select "form[action=?][method=?]", pack_path(@pack), "post" do
    end
  end
end

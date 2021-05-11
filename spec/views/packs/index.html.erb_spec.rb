require 'rails_helper'

RSpec.describe "packs/index", type: :view do
  before(:each) do
    assign(:packs, [
      Pack.create!(),
      Pack.create!()
    ])
  end

  it "renders a list of packs" do
    render
  end
end

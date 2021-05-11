require 'rails_helper'

RSpec.describe "packs/show", type: :view do
  before(:each) do
    @pack = assign(:pack, Pack.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

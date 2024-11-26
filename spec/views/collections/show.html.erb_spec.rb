require 'rails_helper'

RSpec.describe "collections/show", type: :view do
  before(:each) do
    assign(:collection, Collection.create!(
      name: "Name",
      equations_quantity: 2,
      user_admin: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end

require 'rails_helper'

RSpec.describe "groupings/show", type: :view do
  before(:each) do
    assign(:grouping, Grouping.create!(
      name: "Name",
      user_admin: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end

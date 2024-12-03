require 'rails_helper'

RSpec.describe "equations/show", type: :view do
  before(:each) do
    assign(:equation, Equation.create!(
      position_a: 2,
      position_b: 3,
      position_c: 4,
      operator: "Operator",
      unknown_position: "unknown Position",
      collection: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Operator/)
    expect(rendered).to match(/unknown Position/)
    expect(rendered).to match(//)
  end
end

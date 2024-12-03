require 'rails_helper'

RSpec.describe "equations/index", type: :view do
  before(:each) do
    assign(:equations, [
      Equation.create!(
        position_a: 2,
        position_b: 3,
        position_c: 4,
        operator: "Operator",
        unknown_position: "unknown Position",
        collection: nil
      ),
      Equation.create!(
        position_a: 2,
        position_b: 3,
        position_c: 4,
        operator: "Operator",
        unknown_position: "unknown Position",
        collection: nil
      )
    ])
  end

  it "renders a list of equations" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Operator".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("unknown Position".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end

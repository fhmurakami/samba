require 'rails_helper'

RSpec.describe "equations/edit", type: :view do
  let(:equation) {
    Equation.create!(
      position_a: 1,
      position_b: 1,
      position_c: 1,
      operator: "MyString",
      unknown_position: "MyString",
      collection: nil
    )
  }

  before(:each) do
    assign(:equation, equation)
  end

  it "renders the edit equation form" do
    render

    assert_select "form[action=?][method=?]", equation_path(equation), "post" do
      assert_select "input[name=?]", "equation[position_a]"

      assert_select "input[name=?]", "equation[position_b]"

      assert_select "input[name=?]", "equation[position_c]"

      assert_select "input[name=?]", "equation[operator]"

      assert_select "input[name=?]", "equation[unknown_position]"

      assert_select "input[name=?]", "equation[collection_id]"
    end
  end
end

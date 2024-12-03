require 'rails_helper'

RSpec.describe "equations/new", type: :view do
  before(:each) do
    assign(:equation, Equation.new(
      position_a: 1,
      position_b: 1,
      position_c: 1,
      operator: "MyString",
      unknown_position: "MyString",
      collection: nil
    ))
  end

  it "renders new equation form" do
    render

    assert_select "form[action=?][method=?]", equations_path, "post" do
      assert_select "input[name=?]", "equation[position_a]"

      assert_select "input[name=?]", "equation[position_b]"

      assert_select "input[name=?]", "equation[position_c]"

      assert_select "input[name=?]", "equation[operator]"

      assert_select "input[name=?]", "equation[unknown_position]"

      assert_select "input[name=?]", "equation[collection_id]"
    end
  end
end

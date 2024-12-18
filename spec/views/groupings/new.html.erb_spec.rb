require 'rails_helper'

RSpec.describe "groupings/new", type: :view do
  before(:each) do
    assign(:grouping, Grouping.new(
      name: "MyString",
      user_admin: nil
    ))
  end

  it "renders new grouping form" do
    render

    assert_select "form[action=?][method=?]", groupings_path, "post" do
      assert_select "input[name=?]", "grouping[name]"

      assert_select "input[name=?]", "grouping[user_admin_id]"
    end
  end
end

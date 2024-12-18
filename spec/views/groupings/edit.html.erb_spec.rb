require 'rails_helper'

RSpec.describe "groupings/edit", type: :view do
  let(:grouping) {
    Grouping.create!(
      name: "MyString",
      user_admin: nil
    )
  }

  before(:each) do
    assign(:grouping, grouping)
  end

  it "renders the edit grouping form" do
    render

    assert_select "form[action=?][method=?]", grouping_path(grouping), "post" do
      assert_select "input[name=?]", "grouping[name]"

      assert_select "input[name=?]", "grouping[user_admin_id]"
    end
  end
end

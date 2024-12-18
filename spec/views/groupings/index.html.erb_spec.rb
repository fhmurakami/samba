require 'rails_helper'

RSpec.describe "groupings/index", type: :view do
  before(:each) do
    assign(:groupings, [
      Grouping.create!(
        name: "Name",
        user_admin: nil
      ),
      Grouping.create!(
        name: "Name",
        user_admin: nil
      )
    ])
  end

  it "renders a list of groupings" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end

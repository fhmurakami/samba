require 'rails_helper'

RSpec.describe "collections/index", type: :view do
  before(:each) do
    assign(:collections, [
      Collection.create!(
        name: "Name",
        equations_quantity: 2,
        user_admin: nil
      ),
      Collection.create!(
        name: "Name",
        equations_quantity: 2,
        user_admin: nil
      )
    ])
  end

  it "renders a list of collections" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end

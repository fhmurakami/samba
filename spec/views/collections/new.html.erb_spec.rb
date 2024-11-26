require 'rails_helper'

RSpec.describe "collections/new", type: :view do
  before(:each) do
    assign(:collection, Collection.new(
      name: "MyString",
      equations_quantity: 1,
      user_admin: nil
    ))
  end

  it "renders new collection form" do
    render

    assert_select "form[action=?][method=?]", collections_path, "post" do
      assert_select "input[name=?]", "collection[name]"

      assert_select "input[name=?]", "collection[equations_quantity]"

      assert_select "input[name=?]", "collection[user_admin_id]"
    end
  end
end

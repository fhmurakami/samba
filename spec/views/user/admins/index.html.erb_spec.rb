require 'rails_helper'

RSpec.describe "user/admins/index", type: :view do
  before(:each) do
    assign(:user_admins, [
      User::Admin.create!(),
      User::Admin.create!()
    ])
  end

  it "renders a list of user/admins" do
    render
    cell_selector = 'div>p'
  end
end

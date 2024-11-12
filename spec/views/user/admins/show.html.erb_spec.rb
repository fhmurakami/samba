require 'rails_helper'

RSpec.describe "user/admins/show", type: :view do
  before(:each) do
    assign(:user_admin, User::Admin.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

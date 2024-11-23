require 'rails_helper'

RSpec.describe "user/participants/new", type: :view do
  before(:each) do
    assign(:user_participant, User::Participant.new(
      first_name: "MyString",
      last_name: "MyString",
      user_admin: nil
    ))
  end

  it "renders new user_participant form" do
    render

    assert_select "form[action=?][method=?]", user_participants_path, "post" do

      assert_select "input[name=?]", "user_participant[first_name]"

      assert_select "input[name=?]", "user_participant[last_name]"

      assert_select "input[name=?]", "user_participant[user_admin_id]"
    end
  end
end

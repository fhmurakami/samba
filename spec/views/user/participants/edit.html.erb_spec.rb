require 'rails_helper'

RSpec.describe "user/participants/edit", type: :view do
  let(:user_participant) {
    User::Participant.create!(
      first_name: "MyString",
      last_name: "MyString",
      user_admin: nil
    )
  }

  before(:each) do
    assign(:user_participant, user_participant)
  end

  it "renders the edit user_participant form" do
    render

    assert_select "form[action=?][method=?]", user_participant_path(user_participant), "post" do

      assert_select "input[name=?]", "user_participant[first_name]"

      assert_select "input[name=?]", "user_participant[last_name]"

      assert_select "input[name=?]", "user_participant[user_admin_id]"
    end
  end
end

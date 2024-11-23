require 'rails_helper'

RSpec.describe "user/participants/show", type: :view do
  before(:each) do
    assign(:user_participant, User::Participant.create!(
      first_name: "First Name",
      last_name: "Last Name",
      user_admin: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(//)
  end
end

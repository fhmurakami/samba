require "rails_helper"

RSpec.describe "rounds/start", type: :view do
  let(:current_admin) { create(:user_admin) }
  let(:collection) { create(:collection, user_admin: current_admin) }
  let(:participant) { create(:user_participant, user_admin: current_admin) }
  let(:current_round) { create(:round, :uncompleted, collection: collection, participant: participant) }
  before(:each) do
    assign(:current_round, current_round)
    assign(:collection, collection)
    assign(:participant, participant)
  end

  it "renders partial collections/unknown_position_a" do
    assign(:current_equation, create(
      :equation,
      unknown_position: "a",
      user_admin: current_admin
    ))

    sign_in current_admin
    stub_template("shared/_header.html.erb" => "This content")

    render

    expect(rendered).to have_rendered("collections/_unknown_position_a")
  end

  it "renders partial collections/unknown_position_b" do
    assign(:current_equation, create(
      :equation,
      unknown_position: "b",
      user_admin: current_admin
    ))

    sign_in current_admin
    stub_template("shared/_header.html.erb" => "This content")

    render

    expect(rendered).to have_rendered("collections/_unknown_position_b")
  end

  it "renders partial collections/unknown_position_a" do
    assign(:current_equation, create(
      :equation,
      unknown_position: "c",
      user_admin: current_admin
    ))

    sign_in current_admin
    stub_template("shared/_header.html.erb" => "This content")

    render

    expect(rendered).to have_rendered("collections/_unknown_position_c")
  end
end

require "rails_helper"

RSpec.describe "rounds/_form.html.erb", type: :view do
  let(:current_admin) { create(:user_admin) }
  before(:each) do
    assign(:round, Round.new(
      participant: create(:user_participant, first_name: "John", last_name: "Doe", user_admin: current_admin),
      collection: create(:collection, name: "Collection", equations_quantity: 2, user_admin: current_admin)
    ))
  end

  it "renders new round form" do
    sign_in current_admin
    stub_template("shared/_header.html.erb" => "This content")
    render

    expect(rendered).to have_selector("form")
    expect(rendered).to have_selector(
      "label", text: I18n.t("activerecord.models.user/participant")
    )
    expect(rendered).to have_selector("select", text: "John Doe")
    expect(rendered).to have_selector(
      "label", text: I18n.t("activerecord.models.collection")
    )
    expect(rendered).to have_selector("select", text: "Collection")
    expect(rendered).to have_selector("div.actions.mt-1")
    expect(rendered).to have_selector(
      :button,
      name: "commit",
      class: "btn green",
      value: I18n.t("helpers.submit.start_round") # The error is in the text
    )
    expect(rendered).to have_selector(
      "a",
      text: I18n.t("helpers.submit.cancel"),
      class: "btn crimson"
    )
  end
end

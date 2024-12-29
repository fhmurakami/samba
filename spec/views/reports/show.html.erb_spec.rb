require 'rails_helper'

RSpec.describe "reports/show", type: :view do
  let(:current_admin) { create(:user_admin) }

  before(:each) do
    assign(:report, Report.create!(
      user_admin: current_admin,
      collection: create(:collection),
      grouping: create(:grouping)
    ))
  end

  it "renders partial reports/report" do
    sign_in current_admin
    stub_template("shared/_header.html.erb" => "This content")

    render

    expect(rendered).to have_selector("main", class: "background")
    expect(rendered).to have_selector("section", class: "blur")
    expect(rendered).to have_rendered("shared/_header")
    expect(rendered).to have_rendered("reports/_report")
    expect(rendered).to have_link(I18n.t("reports.back"), href: reports_path)
    expect(rendered).to have_selector("button", text: I18n.t("reports.delete"), class: "btn crimson")
  end
end

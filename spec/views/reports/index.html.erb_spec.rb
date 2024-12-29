require 'rails_helper'

RSpec.describe "reports/index", type: :view do
  let(:current_admin) { create(:user_admin) }

  before(:each) do
    assign(:reports, [
      Report.create!(
        user_admin: current_admin,
        collection: create(:collection),
        grouping: create(:grouping)
      ),
      Report.create!(
        user_admin: current_admin,
        collection: create(:collection),
        grouping: create(:grouping)
      )
    ])
  end

  it "renders a list of reports" do
    sign_in current_admin
    stub_template("shared/_header.html.erb" => "This content")

    render

    expect(rendered).to have_selector("main", class: "background")
    expect(rendered).to have_selector("section", class: "blur")
    expect(rendered).to have_rendered("shared/_header")
    expect(rendered).to have_selector("h2", text: I18n.t("activerecord.models.report").pluralize)
    expect(rendered).to have_rendered("reports/_report")
    expect(rendered).to have_link(I18n.t("reports.show"), href: report_path(Report.last))
  end
end

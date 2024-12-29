require 'rails_helper'

RSpec.describe "reports/_report", type: :view do
  let(:current_admin) { create(:user_admin) }
  it "renders a report table" do
    report = create(:report)
    assign(:report, report)

    render(locals: { report: report })

    expect(rendered).to have_selector("table")
    expect(rendered).to have_selector("th > strong", text: report.grouping.name)
    expect(rendered).to have_selector("th", text: report.collection.name)

    report.rounds.each do |round|
      expect(rendered).to have_selector("th", text: round.participant.full_name)
      expect(rendered).to have_selector("th > strong", text: I18n.t("activerecord.models.equation").pluralize)
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.equation.position_a"))
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.equation.operator"))
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.equation.position_b"))
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.equation.position_c"))
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.equation.unknown_position"))
      expect(rendered).to have_selector("th > strong", text: I18n.t("activerecord.models.answer").pluralize)
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.answer.answer_value"))
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.answer.correct_answer"))
      expect(rendered).to have_selector("th", text: I18n.t("activerecord.attributes.answer.time"))

      round.answers.each do |answer|
        expect(rendered).to have_selector("td", text: answer.equation.position_a)
        expect(rendered).to have_selector("td", text: answer.equation.operator)
        expect(rendered).to have_selector("td", text: answer.equation.position_b)
        expect(rendered).to have_selector("td", text: answer.equation.position_c)
        expect(rendered).to have_selector("td", text: answer.equation.unknown_position)
        expect(rendered).to have_selector("td", text: answer.answer_value)
        expect(rendered).to have_selector("td", text: answer.correct_answer ? "✔️" : "❌")
        expect(rendered).to have_selector("td", text: answer.formatted_time)
      end
    end
  end
end

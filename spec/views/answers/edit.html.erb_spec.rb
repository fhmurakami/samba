require 'rails_helper'

RSpec.describe "answers/edit", type: :view do
  let(:answer) {
    Answer.create!(
      user_participant: nil,
      equation: nil,
      answer_value: 1,
      correct_answer: false
    )
  }

  before(:each) do
    assign(:answer, answer)
  end

  it "renders the edit answer form" do
    render

    assert_select "form[action=?][method=?]", answer_path(answer), "post" do
      assert_select "input[name=?]", "answer[user_participant_id]"

      assert_select "input[name=?]", "answer[equation_id]"

      assert_select "input[name=?]", "answer[answer_value]"

      assert_select "input[name=?]", "answer[correct_answer]"
    end
  end
end

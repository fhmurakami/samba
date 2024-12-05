require 'rails_helper'

RSpec.describe "answers/new", type: :view do
  before(:each) do
    assign(:answer, Answer.new(
      user_participant: nil,
      equation: nil,
      answer_value: 1,
      correct_answer: false
    ))
  end

  it "renders new answer form" do
    render

    assert_select "form[action=?][method=?]", answers_path, "post" do
      assert_select "input[name=?]", "answer[user_participant_id]"

      assert_select "input[name=?]", "answer[equation_id]"

      assert_select "input[name=?]", "answer[answer_value]"

      assert_select "input[name=?]", "answer[correct_answer]"
    end
  end
end

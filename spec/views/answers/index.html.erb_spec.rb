require 'rails_helper'

RSpec.describe "answers/index", type: :view do
  before(:each) do
    assign(:answers, [
      Answer.create!(
        user_participant: nil,
        equation: nil,
        answer_value: 2,
        correct_answer: false
      ),
      Answer.create!(
        user_participant: nil,
        equation: nil,
        answer_value: 2,
        correct_answer: false
      )
    ])
  end

  it "renders a list of answers" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end

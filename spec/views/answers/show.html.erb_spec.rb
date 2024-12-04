require 'rails_helper'

RSpec.describe "answers/show", type: :view do
  before(:each) do
    assign(:answer, Answer.create!(
      user_participant: nil,
      equation: nil,
      answer_value: 2,
      correct_answer: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
  end
end

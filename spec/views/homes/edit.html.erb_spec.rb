require 'rails_helper'

RSpec.describe "homes/edit", type: :view do
  let(:home) {
    Home.create!()
  }

  before(:each) do
    assign(:home, home)
  end

  it "renders the edit home form" do
    render

    assert_select "form[action=?][method=?]", home_path(home), "post" do
    end
  end
end

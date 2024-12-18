require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'database columns' do
    it { should have_db_column(:user_participant_id).of_type(:integer) }
    it { should have_db_column(:collection_equation_id).of_type(:integer) }
    it { should have_db_column(:answer_value).of_type(:integer) }
    it { should have_db_column(:correct_answer).of_type(:boolean) }
    it { should have_db_column(:time_spent).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_column(:round_id).of_type(:integer) }
  end

  describe 'model associations' do
    it { should belong_to(:participant).class_name('User::Participant') }
    it { should belong_to(:collection_equation) }
    it { should belong_to(:round) }
  end

  describe "when creating a new Answer" do
    context 'and the answer is valid' do
      let(:answer) { build_stubbed :answer }
      it 'should return true' do
        expect(answer).to be_valid
      end
    end

    context 'and the answer is valid but already exists' do
      let(:answer) { create :answer }
      let(:answer_with_same_attributes) do
        build_stubbed :answer,
          answer_value: answer.answer_value,
          collection_equation_id: answer.collection_equation_id,
          user_participant_id: answer.user_participant_id,
          round_id: answer.round_id
      end
      it 'should be invalid' do
        expect(answer_with_same_attributes).not_to be_valid
      end
    end

    context 'and the answer is invalid' do
      let(:answer) { build :answer, :invalid }
      it 'should not save' do
        expect(answer).not_to be_valid
      end
    end
  end
end

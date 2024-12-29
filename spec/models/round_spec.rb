require 'rails_helper'

RSpec.describe Round, type: :model do
  describe 'database columns' do
    it { should have_db_column(:collection_id).of_type(:integer) }
    it { should have_db_column(:user_participant_id).of_type(:integer) }
    it { should have_db_column(:current_equation_id).of_type(:integer) }
    it { should have_db_column(:started_at).of_type(:datetime) }
    it { should have_db_column(:completed_at).of_type(:datetime) }
    it { should have_db_column(:equation_started_at).of_type(:datetime) }
    it { should have_db_column(:round_time).of_type(:integer) }
  end

  describe 'model associations' do
    it { should belong_to(:collection) }
    it { should belong_to(:participant).class_name('User::Participant') }
    it { should belong_to(:report).optional }
    it { should have_many(:answers) }
  end


  describe 'model validations' do
    let(:user_admin) { create(:user_admin) }
    let(:collection) { create(:collection, user_admin: user_admin) }
    let(:grouping) { create(:grouping, user_admin: user_admin) }
    let(:participant) {
      create(
        :user_participant,
        grouping: grouping,
        user_admin: user_admin
      )
    }
    let(:report) {
      create(
        :report,
        user_admin: user_admin,
        collection: collection,
        grouping: grouping
      )
    }

    context "when report is nil" do
      it "should be valid" do
        round = create(:round, report: nil)

        expect(round).to be_valid
        expect(round.errors).to be_empty
      end
    end

    context 'when rounds count is less or equal to the number of participants in a grouping' do
      it 'should be valid with no errors' do
        round = create(
          :round,
          collection: collection,
          participant: participant,
          report: report
        )

        expect(round).to be_valid
        expect(round.errors).to be_empty
      end
    end

    context 'when rounds count is greater than the number of participants in a grouping' do
      it 'should not be valid' do
        grouping.reload

        report.rounds <<  [
          create(
            :round,
            collection: collection,
            participant: participant,
            report: report
          )
        ]

        round = create(
          :round,
          collection: collection,
          participant: create(:user_participant, user_admin: user_admin),
          report: report
        )


        expect(round).not_to be_valid
        expect(round.errors).not_to be_empty
        expect(round.errors.full_messages).to include(
          I18n.t(
            'errors.messages.too_many_rounds',
            model: round.model_name.human,
            grouping: grouping.name,
            count: grouping.participants.length
          )
        )
      end
    end
  end
end

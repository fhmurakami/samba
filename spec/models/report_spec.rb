require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'database columns' do
    it { should have_db_column(:user_admin_id).of_type(:integer) }
    it { should have_db_column(:collection_id).of_type(:integer) }
    it { should have_db_column(:grouping_id).of_type(:integer) }
  end

  describe 'model associations' do
    it { should belong_to(:user_admin).class_name('User::Admin') }
    it { should belong_to(:collection) }
    it { should belong_to(:grouping) }
    it { should have_many(:rounds) }
    it do
      should have_many(:participants)
        .class_name('User::Participant')
        .through(:grouping)
    end
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

    context 'when rounds count is less or equal to the number of participants in a grouping' do
      it 'should be valid with no errors' do
        report.rounds << create(
          :round,
          collection: collection,
          participant: participant,
          report: report
        )

        expect(report).to be_valid
        expect(report.errors).to be_empty
      end
    end

    context 'when rounds count is greater than the number of participants in a grouping' do
      it 'should not be valid' do
        report.rounds <<  [
          create(
            :round,
            collection: collection,
            participant: participant,
            report: report
          ),
          create(
            :round,
            collection: collection,
            participant: create(:user_participant, user_admin: user_admin),
            report: report
          )
        ]

        grouping.reload

        expect(report).not_to be_valid
        expect(report.errors).not_to be_empty
        expect(report.errors.full_messages).to include(
          I18n.t(
            'errors.messages.too_many_rounds',
            model: report.model_name.human,
            grouping: grouping.name,
            count: grouping.participants.length
          )
        )
      end
    end
  end
end

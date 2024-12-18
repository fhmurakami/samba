require 'rails_helper'

RSpec.describe Grouping, type: :model do
  describe 'database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:user_admin_id).of_type(:integer) }
  end

  describe 'model associations' do
    it { should belong_to(:user_admin).class_name('User::Admin') }
    it { should have_many(:participants).class_name('User::Participant') }
  end

  describe 'model validations' do
    it { should validate_presence_of(:name) }
  end

  describe "#remove_participant" do
    it "removes a participant from the grouping" do
      grouping = create(:grouping)
      participant = create(:user_participant, grouping: grouping)
      expect(grouping.participants).to include(participant)
      grouping.remove_participant(participant)
      expect(grouping.participants).to_not include(participant)
    end
  end
end

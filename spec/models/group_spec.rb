require 'rails_helper'

RSpec.describe Group, type: :model do
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
    it "removes a participant from the group" do
      group = create(:group)
      participant = create(:user_participant, group: group)
      expect(group.participants).to include(participant)
      group.remove_participant(participant)
      expect(group.participants).to_not include(participant)
    end
  end
end

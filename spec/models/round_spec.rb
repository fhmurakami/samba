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
    it { should have_many(:answers) }
  end
end

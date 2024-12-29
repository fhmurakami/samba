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
end

require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe 'database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:equations_quantity).of_type(:integer) }
    it { should have_db_column(:user_admin_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'model associations' do
    it { should belong_to(:user_admin).class_name('User::Admin') }
    it { should have_many(:collection_equations) }
    it { should have_many(:equations).through(:collection_equations) }
  end

  describe 'model validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:equations_quantity) }
  end
end

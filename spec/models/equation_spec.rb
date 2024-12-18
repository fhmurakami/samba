require 'rails_helper'

RSpec.describe Equation, type: :model do
  describe 'database columns' do
    it { should have_db_column(:position_a).of_type(:integer) }
    it { should have_db_column(:position_b).of_type(:integer) }
    it { should have_db_column(:position_c).of_type(:integer) }
    it { should have_db_column(:operator).of_type(:string) }
    it { should have_db_column(:unknown_position).of_type(:string) }
    it { should have_db_column(:user_admin_id).of_type(:integer) }
  end

  describe 'model associations' do
    it { should belong_to(:user_admin).class_name('User::Admin') }
    it { should have_many(:collection_equations) }
    it { should have_many(:answers).through(:collection_equations) }
    it { should have_many(:collections).through(:collection_equations) }
  end

  describe 'model validations' do
    it { should validate_presence_of(:position_a) }
    it { should validate_presence_of(:position_b) }
    it { should validate_presence_of(:position_c) }
    it { should validate_presence_of(:operator) }
    it { should validate_presence_of(:unknown_position) }
  end
end

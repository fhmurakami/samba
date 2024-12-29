require 'rails_helper'

RSpec.describe User::Participant, type: :model do
  it { is_expected.to have_db_column(:first_name).of_type(:string) }
  it { is_expected.to have_db_column(:last_name).of_type(:string) }
  it { is_expected.to have_db_column(:birth_date).of_type(:date) }

  it { is_expected.to belong_to :user_admin }
  it { is_expected.to belong_to(:grouping).optional }
  it { is_expected.to have_many(:answers).dependent(:destroy).with_foreign_key(:user_participant_id) }

  describe "when creating a new User::Participant" do
    it "is valid with valid attributes" do
      expect(User::Participant.new(first_name: "John", last_name: "Doe", birth_date: 5.years.ago, grouping: build(:grouping), user_admin: build(:user_admin))).to be_valid
    end

    it "is not valid without a first name" do
      expect(User::Participant.new(first_name: nil, last_name: "Doe", user_admin: build(:user_admin))).to_not be_valid
    end

    it "is not valid without a last name" do
      expect(User::Participant.new(first_name: "John", last_name: nil, user_admin: build(:user_admin))).to_not be_valid
    end

    it "is not valid without a user_admin" do
      expect(User::Participant.new(first_name: "John", last_name: "Doe", user_admin: nil)).to_not be_valid
    end
  end

  describe "#full_name" do
    it "returns the first and last name of the participant" do
      participant = User::Participant.new(first_name: "John", last_name: "Doe")
      expect(participant.full_name).to eq("John Doe")
    end
  end
end

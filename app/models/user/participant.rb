module User
  class Participant < ApplicationRecord
    attr_reader :full_name

    belongs_to :user_admin, class_name: "User::Admin"
    has_and_belongs_to_many :groups, foreign_key: :user_participant_id, inverse_of: :user_participant
    has_many :answers, dependent: :destroy

    validates :first_name, :last_name, :birth_date, presence: true

    def full_name
      @full_name ||= "#{first_name} #{last_name}"
    end
  end
end

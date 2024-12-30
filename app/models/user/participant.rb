module User
  class Participant < ApplicationRecord
    attr_reader :full_name

    belongs_to :user_admin, class_name: "User::Admin"
    belongs_to :grouping, optional: true
    has_many :answers, dependent: :destroy, foreign_key: :user_participant_id
    has_many :rounds
    has_many :reports, through: :rounds

    validates :first_name, :last_name, :birth_date, presence: true

    def full_name
      @full_name ||= "#{first_name} #{last_name}"
    end
  end
end

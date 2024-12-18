module User
  class Participant < ApplicationRecord
    attr_reader :full_name

    belongs_to :user_admin, class_name: "User::Admin"
    belongs_to :group, optional: true
    has_many :answers, dependent: :destroy

    validates :first_name, :last_name, :birth_date, presence: true

    def full_name
      @full_name ||= "#{first_name} #{last_name}"
    end
  end
end

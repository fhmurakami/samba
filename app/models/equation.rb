class Equation < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", foreign_key: "user_admin_id"
  has_many :collection_equations
  has_many :answers, through: :collection_equations
  has_many :collections, through: :collection_equations

  validates :position_a, :position_b, :position_c, :operator, :unknown_position, presence: true
end

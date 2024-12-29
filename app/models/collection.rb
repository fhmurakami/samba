class Collection < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", dependent: :destroy
  has_many :collection_equations, dependent: :destroy
  has_many :equations, through: :collection_equations
  has_many :reports

  validates :name, :equations_quantity, presence: true
end

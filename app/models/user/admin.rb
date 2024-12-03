class User::Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections, foreign_key: :user_admin_id, dependent: :destroy
  has_many :equations, foreign_key: :user_admin_id, dependent: :destroy
  has_many :groups, foreign_key: :user_admin_id, dependent: :destroy
  has_many :participants, class_name: "User::Participant", foreign_key: :user_admin_id, inverse_of: :user_admin, dependent: :destroy

  validates :first_name, :last_name, presence: true
end

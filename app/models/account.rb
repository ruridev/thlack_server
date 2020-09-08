class Account < ApplicationRecord
  has_secure_password

  has_many :account_users
  has_many :users, through: :account_users

  validates :identifier, presence: true
  validates :type, presence: true
end

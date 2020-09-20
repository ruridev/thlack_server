class Account < ApplicationRecord
  has_secure_password

  has_many :account_users
  has_many :users, through: :account_users

  validates :identifier, presence: true
  validates :type, presence: true

  enum status: {
    active: 1,
    inactive: 9,
  }
end

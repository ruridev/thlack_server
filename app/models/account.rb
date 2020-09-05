class Account < ApplicationRecord
  has_secure_password

  belongs_to :user

  validates :identifier, presence: true
  validates :type, presence: true
end

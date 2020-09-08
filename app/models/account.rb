class Account < ApplicationRecord
  has_secure_password

  validates :identifier, presence: true
  validates :type, presence: true
end

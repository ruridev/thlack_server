class User < ApplicationRecord
  has_one :account_user
  has_one :account, through: :account_user
end

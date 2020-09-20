class Workspace < ApplicationRecord
  has_many :channels
  has_many :channel_users
  has_many :users, through: :channel_users
end

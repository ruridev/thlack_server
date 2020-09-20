class User < ApplicationRecord
  has_one :account_user
  has_one :account, through: :account_user
  has_many :workspace_users
  has_many :workspaces, through: :workspace_users
  has_many :channel_users
  has_many :channels, through: :channel_users

  has_many :friend_connections, class_name: 'Friend', foreign_key: :subject_user_id
  has_many :friends, through: :friend_connections, source: :object_user

  attr_reader :token

  def with_token(token)
    @token = token
    self
  end

# 네이밍
#  has_many :friend_requests, class_name: 'FriendRequest', foreign_key: :sender_user_id
#  has_many :friend_requests, class_name: 'FriendRequest', foreign_key: :receiver_user_id
#  has_many :friend_requests, through: :friend_requests, source: :sender_user
#  has_many :friend_requests, through: :friend_requests, source: :receiver_user
end

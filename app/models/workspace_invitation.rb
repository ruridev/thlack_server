class WorkspaceInvitation < ApplicationRecord  
  belongs_to :workspace
  belongs_to :sender_user, class_name: 'User', foreign_key: :sender_user_id
  belongs_to :receiver_user, class_name: 'User', foreign_key: :receiver_user_id

  enum status: {
    before_accept: 1,
    accepted: 2,
    expired: 3,
  }
end

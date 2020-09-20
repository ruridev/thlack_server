class Friend < ApplicationRecord
  belongs_to :subject_user, class_name: "User", foreign_key: :subject_user_id
  belongs_to :object_user, class_name: "User", foreign_key: :object_user_id
end

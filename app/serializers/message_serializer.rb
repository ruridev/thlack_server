class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :body, :user_id, :channel_id, :send_at
end
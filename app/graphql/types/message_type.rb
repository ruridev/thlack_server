module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :send_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, UserType, null: false
    field :channel, ChannelType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

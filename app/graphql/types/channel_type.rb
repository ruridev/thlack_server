module Types
  class ChannelType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :workspace, WorkspaceType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

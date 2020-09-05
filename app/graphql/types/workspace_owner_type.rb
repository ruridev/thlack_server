module Types
  class WorkspaceOwnerType < Types::BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :workspace, WorkspaceType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

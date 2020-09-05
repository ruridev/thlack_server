module Types
  class WorkspaceUserType < Types::BaseObject
    field :id, ID, null: false
    field :workspace, WorkspaceType, null: false
    field :user, UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

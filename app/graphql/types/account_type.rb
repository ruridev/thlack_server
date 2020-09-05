module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String, null: false
    field :type, String, null: false
    field :password, String, null: false
    field :user, UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

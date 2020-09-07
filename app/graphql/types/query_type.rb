module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, Int, required: false
    end
    def user(id:)
      User.find_by(id: id)
    end

    field :workspaces, [Types::WorkspaceType], null: false
    def workspaces
      Workspace.all
    end

    field :workspace, Types::WorkspaceType, null: false do
      argument :id, Int, required: false
    end
    def workspace(id:)
      Workspace.find_by(id: id)
    end

    field :accounts, [Types::AccountType], null: false
    def accounts
      Account.all
    end

    field :account, Types::AccountType, null: false do
      argument :id, Int, required: false
    end
    def account(id:)
      Account.find_by(id: id)
    end
  end
end

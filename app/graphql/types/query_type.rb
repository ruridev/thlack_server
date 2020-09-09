module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    def users
      context[:current_account].users
    end

    field :token, String, null: false do
      argument :user_id, Int, required: true
    end
    def token(user_id:)
      user = context[:current_account].users.find(user_id)
      JWT.encode({ user_id: user_id }, 'MY-SECRET', 'HS256') if user.present?
    end

    field :user, Types::UserType, null: false do
      argument :id, Int, required: true
    end
    def user(id:)
      User.find(id)
    end

    field :workspaces, [Types::WorkspaceType], null: false
    def workspaces
      Workspace.all
    end

    field :workspace, Types::WorkspaceType, null: false do
      argument :id, Int, required: false
    end
    def workspace(id:)
      Workspace.find(id)
    end

    field :channels, [Types::ChannelType], null: false do
      argument :id, Int, required: false
    end
    def channels(id:)
      Channel.where(workspace_id: id)
    end

    field :channel, Types::ChannelType, null: false do
      argument :workspace_id, Int, required: false
      argument :id, Int, required: false
    end
    def channel(id:, workspace_id:)
      Channel.find_by(id: id, workspace_id: workspace_id)
    end

    field :accounts, [Types::AccountType], null: false
    def accounts
      Account.all
    end

    field :account, Types::AccountType, null: false do
      argument :id, Int, required: false
    end
    def account(id:)
      Account.find(id)
    end
  end
end

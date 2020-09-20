module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false
    def users
      raise 'Unauthorized' unless context[:current_account]

      context[:current_account].users
    end

    field :user, Types::UserType, null: false do
      argument :id, Int, required: true
    end
    def user(id:)
      raise 'Unauthorized' unless context[:current_user]

      User.find(id)
    end

    field :user_token, Types::UserType, null: false do
      argument :id, Int, required: true
    end
    def user_token(id:)
      raise 'Unauthorized' unless context[:current_account]

      user = context[:current_account].users.find(id)
      user.with_token(JWT.encode({ user_id: id }, 'MY-SECRET', 'HS256')) if user.present?
    end

    field :login_user, Types::UserType, null: false
    def login_user
      raise 'Unauthorized' unless context[:current_user]

      context[:current_user]
    end

    field :my_workspaces, [Types::WorkspaceType], null: false
    def my_workspaces
      raise 'Unauthorized' unless context[:current_user]

      context[:current_user].workspaces
    end

    field :workspace, Types::WorkspaceType, null: false do
      argument :id, Int, required: false
    end
    def workspace(id:)
      raise 'Unauthorized' unless context[:current_user]

      Workspace.find(id)
    end

    field :search_workspaces, [Types::WorkspaceType], null: false do
      argument :name, String, required: true
    end
    def search_workspaces(name:)
      raise 'Unauthorized' unless context[:current_user]

      Workspace.where(['name LIKE ?', "%#{name}%"])
    end

    field :channels, [Types::ChannelType], null: false do
      argument :id, Int, required: true
    end
    def channels(id:)
      raise 'Unauthorized' unless context[:current_user]

      Channel.where(workspace_id: id)
    end

    field :channel, Types::ChannelType, null: false do
      argument :workspace_id, Int, required: false
      argument :id, Int, required: false
    end
    def channel(id:, workspace_id:)
      raise 'Unauthorized' unless context[:current_user]

      Channel.find_by(id: id, workspace_id: workspace_id)
    end

    field :join_channel, Types::ChannelType, null: false do
      argument :channel_id, Int, required: true
    end
    def join_channel(channel_id:)
      raise 'Unauthorized' unless context[:current_user]

      channel = context[:current_user].channels.find(channel_id)
      WorkspacesChannel.broadcast_to(channel, {
        channel: ChannelSerializer.new(channel),
        users: UserSerializer.new(channel.users),
        messages: MessageSerializer.new(channel.messages)
      })
      channel
    end
  end
end

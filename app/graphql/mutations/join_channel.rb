module Mutations
  class JoinChannel < BaseMutation
    graphql_name 'JoinChannel'

    field :channel, Types::ChannelType, null: true
    field :result, Boolean, null: true

    argument :workspace_id, Int, required: true
    argument :channel_id, Int, required: true

    def resolve(**args)
      raise 'Unauthorized' unless context[:current_user]

      ActiveRecord::Base.transaction do
        workspace = WorkspaceUser.find_by(workspace_id: args[:workspace_id], user: context[:current_user]).workspace
        raise 'Bad Request' unless workspace

        channel = workspace.channels.find_by(id: args[:channel_id])
        raise 'Bad Request' unless channel
        
        channel_user = ChannelUser.create_or_find_by(
          channel: channel,
          user: context[:current_user]
        )
        WorkspacesChannel.broadcast_to(channel, {
          channel: ChannelSerializer.new(channel),
          users: UserSerializer.new(channel.users),
          messages: MessageSerializer.new(channel.messages)
        })
        {
          channel: channel,
          result: channel_user.errors.blank?
        }
      end
    end
  end
end

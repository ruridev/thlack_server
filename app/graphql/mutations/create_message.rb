module Mutations
  class CreateMessage < BaseMutation
    graphql_name 'CreateMessage'

    field :message, Types::MessageType, null: true
    field :result, Boolean, null: true

    argument :body, String, required: true
    argument :channel_id, Int, required: true

    def resolve(**args)
      message = Message.create(
        body: args[:body],
        user_id: context[:current_user].id, 
        channel_id: args[:channel_id], 
        send_at: Time.current
      )
      channel = Channel.find(message.channel_id)
      WorkspacesChannel.broadcast_to(channel, {
        channel: ChannelSerializer.new(channel),
        users: UserSerializer.new(channel.users),
        messages: MessageSerializer.new(channel.messages)
      })

      {
        message: message,
        result: message.errors.blank?
      }
    end
  end
end

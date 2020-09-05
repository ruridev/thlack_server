module Mutations
  class CreateChannelUser < BaseMutation
    graphql_name 'CreateChannelUser'

    field :channel, Types::ChannelUserType, null: true
    field :result, Boolean, null: true

    argument :channel_id, Int, required: true
    argument :user_id, Int, required: true

    def resolve(**args)
      channel_user = ChannelUser.create(channel_id: args[:channel_id], user_id: args[:user_id])
      {
        channel_user: channel_user,
        result: channel_user.errors.blank?
      }
    end
  end
end

module Mutations
  class CreateMessage < BaseMutation
    graphql_name 'CreateMessage'

    field :message, Types::MessageType, null: true
    field :result, Boolean, null: true

    argument :body, String, required: true
    argument :user_id, Int, required: true
    argument :channel_id, Int, required: true

    def resolve(**args)
      message = Message.create(body: args[:body], user_id: args[:user_id], channel_id: args[:channel_id], send_at: Time.current)
      {
        message: message,
        result: message.errors.blank?
      }
    end
  end
end

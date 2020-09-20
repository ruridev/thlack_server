module Mutations
  class CreateChannel < BaseMutation
    graphql_name 'CreateChannel'

    field :channel, Types::ChannelType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true
    argument :workspace_id, Int, required: true

    def resolve(**args)
      ActiveRecord::Base.transaction do
        channel = Channel.create_or_find_by(name: args[:name], workspace_id: args[:workspace_id])
        ChannelUser.create_or_find_by(user: context[:current_user], channel: channel)
        {
          channel: channel,
          result: channel.errors.blank?
        }
      end
    end
  end
end

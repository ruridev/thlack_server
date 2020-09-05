module Mutations
  class CreateChannel < BaseMutation
    graphql_name 'CreateChannel'

    field :channel, Types::ChannelType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true
    argument :workspace_id, Int, required: true

    def resolve(**args)
      channel = Channel.create(name: args[:name], workspace_id: args[:workspace_id])
      {
        channel: channel,
        result: channel.errors.blank?
      }
    end
  end
end

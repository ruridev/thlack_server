module Types
  class MutationType < Types::BaseObject
    field :create_channel_user, mutation: Mutations::CreateChannelUser
    field :create_workspace_user, mutation: Mutations::CreateWorkspaceUser
    field :create_message, mutation: Mutations::CreateMessage
    field :create_channel, mutation: Mutations::CreateChannel
    field :create_workspace, mutation: Mutations::CreateWorkspace
    field :create_account, mutation: Mutations::CreateAccount
    field :create_user, mutation: Mutations::CreateUser
  end
end

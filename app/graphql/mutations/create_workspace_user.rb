module Mutations
  class CreateWorkspaceUser < BaseMutation
    graphql_name 'CreateWorkspaceUser'

    field :workspace_user, Types::WorkspaceUserType, null: true
    field :result, Boolean, null: true

    argument :workspace_id, Int, required: true
    argument :user_id, Int, required: true

    def resolve(**args)
      workspace_user = WorkspaceUser.create(workspace_id: args[:workspace_id], workspace_id: args[:user_id])
      {
        workspace_user: workspace_user,
        result: workspace_user.errors.blank?
      }
    end
  end
end

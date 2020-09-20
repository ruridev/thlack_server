module Mutations
  class JoinWorkspace < BaseMutation
    graphql_name 'JoinWorkspace'

    field :workspace, Types::WorkspaceType, null: true
    field :result, Boolean, null: true

    argument :workspace_id, Int, required: true

    def resolve(**args)
      ActiveRecord::Base.transaction do
        workspace_user = WorkspaceUser.create_or_find_by(
          workspace_id: args[:workspace_id],
          user: context[:current_user]
        )
        {
          workspace: workspace_user.workspace,
          result: workspace_user.errors.blank?
        }
      end
    end
  end
end

module Mutations
  class CreateWorkspace < BaseMutation
    graphql_name 'CreateWorkspace'

    field :workspace, Types::WorkspaceType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true

    def resolve(**args)
      ActiveRecord::Base.transaction do
        workspace = Workspace.create(name: args[:name])
        WorkspaceUser.create(user: context[:current_user], workspace: workspace)
        {
          workspace: workspace,
          result: workspace.errors.blank?
        }
      end
    end
  end
end

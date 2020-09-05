module Mutations
  class CreateWorkspace < BaseMutation
    graphql_name 'CreateWorkspace'

    field :workspace, Types::WorkspaceType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true

    def resolve(**args)
      workspace = Workspace.create(name: args[:name])
      {
        workspace: workspace,
        result: workspace.errors.blank?
      }
    end
  end
end

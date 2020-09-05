module Mutations
  class CreateUser < BaseMutation
    graphql_name 'CreateUser'

    field :user, Types::UserType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true

    def resolve(**args)
      user = User.create(name: args[:name])
      {
        user: user,
        result: user.errors.blank?
      }
    end
  end
end

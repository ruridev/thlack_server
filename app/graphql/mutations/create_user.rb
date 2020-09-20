module Mutations
  class CreateUser < BaseMutation
    graphql_name 'CreateUser'

    field :user, Types::UserType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true

    def resolve(**args)
      ActiveRecord::Base.transaction do
        account_users = AccountUser.eager_load(:user).where(account: context[:current_account])
        user = account_users.select{|account_user| account_user.user.name == args[:name] }.first
        unless user
          user = User.create(name: args[:name])
          AccountUser.create(account: context[:current_account], user: user)
        end

        {
          user: user,
          result: user.errors.blank?
        }
      end
    end
  end
end

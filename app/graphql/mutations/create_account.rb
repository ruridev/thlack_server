module Mutations
  class CreateAccount < BaseMutation
    graphql_name 'CreateAccount'

    field :account, Types::AccountType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true
    argument :credentials, Types::AccountCredentialsInput, required: true
    
    def resolve(**args)
      ActiveRecord::Base.transaction do 
        user = User.create(name: args[:name])
        account = Account.create(
          identifier: args[:credentials][:identifier],
          password: args[:credentials][:password],
          user: user,
          type: ::AccountProvider::EmailProvider,
        )
        return { account: account,
                 result: account.errors.blank? }
      end

      {
        account: nil,
        result: false
      }
    end
  end
end
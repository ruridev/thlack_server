module Mutations
  class CreateAccount < BaseMutation
    graphql_name 'CreateAccount'

    field :account, Types::AccountType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true
    argument :credentials, Types::AccountCredentialsInput, required: true
    
    def resolve(**args)
      account = nil
      user = nil
      ActiveRecord::Base.transaction do 
        user = User.create(name: args[:name])
        account = Account.create(identifier: args[:credentials][:identifier], password: args[:credentials][:password], user: user, type: 'normal')
      end
      {
        user: user,
        identifier: account.identifier,
        result: account.errors.blank?
      }
    end
  end
end

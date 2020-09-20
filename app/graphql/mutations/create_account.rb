module Mutations
  class CreateAccount < BaseMutation
    graphql_name 'CreateAccount'

    field :user, Types::UserType, null: true
    field :account, Types::AccountType, null: true
    field :result, Boolean, null: true

    argument :displayName, String, required: false
    argument :email, String, required: true
    argument :credentials, Types::AccountCredentialsInput, required: true

    def resolve(**args)
      type = case args[:credentials][:providerId]
             when 'github.com'
               AccountProvider::GithubProvider
             when 'google.com'
               AccountProvider::GoogleProvider
             end

      alread_exists_account = type.find_by(
        identifier: args[:credentials][:identifier]
      )
      return {
        account: alread_exists_account,
        user: alread_exists_account.users.first,
        result: true
      } if alread_exists_account
      
      ActiveRecord::Base.transaction do
        new_account = ::Account.active.create_or_find_by(
          identifier: args[:credentials][:identifier],
          type: type,
          password: 'pwd', #args[:credentials][:password],
          password_confirmation: 'pwd', #args[:credentials][:password],
        )

        new_user = User.create_or_find_by(
          name: args[:displayName] || args[:email]
        )

        AccountUser.create_or_find_by(
          account_id: new_account.id,
          user_id: new_user.id,
        )

        { 
          account: new_account,
          user: new_user,
          result: new_account.errors.blank?
        }
      rescue => e
        Rails.logger.info e
        new_account = ::Account.create(
          identifier: args[:credentials][:identifier],
          type: type
        )
        {
          account: new_account,
          result: true
        }
      end
    end
  end
end
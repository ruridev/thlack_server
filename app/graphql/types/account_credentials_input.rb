module Types
  class AccountCredentialsInput < Types::BaseInputObject
    graphql_name 'ACCOUNT_CREDENTIALS_INPUT'

    argument :identifier, String, required: true
    argument :password, String, required: false
    argument :providerId, String, required: true
  end
end

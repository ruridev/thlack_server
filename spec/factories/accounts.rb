FactoryBot.define do
  factory :account do
    identifier { "MyString" }
    type { ::AccountProvider::EmailProvider.to_s }
    password { "MyString" }
    user { nil }
  end
end

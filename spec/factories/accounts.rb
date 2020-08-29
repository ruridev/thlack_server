FactoryBot.define do
  factory :account do
    identifier { "MyString" }
    type { "" }
    password { "MyString" }
    user { nil }
  end
end

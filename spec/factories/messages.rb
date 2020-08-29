FactoryBot.define do
  factory :message do
    body { "MyText" }
    send_at { "2020-09-02 16:24:23" }
    user_id { 1 }
    channel { nil }
  end
end

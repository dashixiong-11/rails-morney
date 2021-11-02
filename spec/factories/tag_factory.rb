FactoryBot.define do
  factory :tag do
    name { SecureRandom.hex 10 }
    user
  end
end
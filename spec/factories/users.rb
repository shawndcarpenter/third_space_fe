FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
    role { User.roles.keys.sample }
    otp_secret_key { ROTP::Base32.random_base32 }
  end
end
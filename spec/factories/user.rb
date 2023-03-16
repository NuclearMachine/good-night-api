FactoryBot.define do
  factory :user do
    name { Faker::Name.name }

    sequence :email do |n|
      "#{n}#{Faker::Internet.email}"
    end

    password { 'password123' }
    password_confirmation { 'password123' }
  end
end

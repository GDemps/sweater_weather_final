FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {Faker::Creature::Dog.name}
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    sequence :name do
      Faker::Company.bs
    end
    user
  end
end

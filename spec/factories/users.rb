FactoryGirl.define do
  factory :user do
    email Faker::Internet.free_email
    password "password"

    factory :user_with_goals do
      goals do
        (1..3).map do
          FactoryGirl.create(:goal)
        end
      end

      after(:create) do |user|
        user.goals.each do |g|
          g.user_id = user.id
        end
      end
    end
  end
end


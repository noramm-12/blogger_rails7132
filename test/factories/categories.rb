FactoryBot.define do
  factory :category do
    name { "Sports" }

    trait :category2 do
    name { "Fashion" }
    end

    trait :category3 do
      name { "News" }
    end
  end
end

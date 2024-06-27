FactoryBot.define do
  factory :article do
    title { "title" }
    content { "description" }
    # association :no_admin_user
    association :user, factory: :no_admin_user

    trait :article2 do
      # association :admin_user # association :user, factory: :admin_user
      association :user, factory: :admin_user
    end
  end
  # article = FactoryBot.create(:article)
  # article2 = FactoryBot.create(:article, :article2)
end

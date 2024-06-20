FactoryBot.define do
  factory :no_admin_user, class: 'User' do
    username { "normal" }
    email { "normal@example.com" }
    password { "password" }
    admin { false }

    trait :no_admin_user2 do
      username { "other" }
      email { "other@example.com" }
    end
  end

  factory :admin_user, class: 'User' do
    username { "nora" }
    email { "nora@example.com" }
    password { "password" }
    admin { true }
  end
end
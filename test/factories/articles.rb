# FactoryBot.define do
#   factory :article do
#     title { "title" }
#     description { "description" }
#     association :user
#
#     trait :article2 do
#       association :admin_user
#       # association :user, factory: :admin_user
#     end
#   end
#   # article1 = FactoryBot.create(:article)
#   # article2 = FactoryBot.create(:article, :article2)
# end

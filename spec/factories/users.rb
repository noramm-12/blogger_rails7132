# FactoryBot.define do
#   factory :no_admin_user, class: 'User' do
#     username { "normal" }
#     email { "normal@example.com" }
#     password { "password" }
#     admin { false }
#   end
#
#   factory :admin_user, class: 'User' do
#     username { "nora" }
#     email { "nora@example.com" }
#     password { "password" }
#     admin { true }
#   end
# end
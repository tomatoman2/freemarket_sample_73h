FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"ito"}
    first_name            {"hanako"}
    kana_family_name      {"ito"}
    kana_first_name       {"hanako"}
    birthday              {"20021212"}
  end

end
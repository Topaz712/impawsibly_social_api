FactoryBot.define do
  factory :pet do
    name { "MyString" }
    species { "MyString" }
    breed { "MyString" }
    sex { "MyString" }
    birthday { "2024-02-26" }
    is_vaccinated { false }
    is_fixed { false }
    owner { nil }
  end
end

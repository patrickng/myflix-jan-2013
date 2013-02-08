Fabricator(:user) do
  full_name { Faker::Name.name }
  email_address { Faker::Internet.email }
  password { Faker::Lorem.characters(4) }
end
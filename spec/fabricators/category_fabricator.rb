Fabricator(:category) do
  name { sequence(:name) { |i| "Category #{i}" } }
  description { Faker::Lorem.paragraph(2) }
end
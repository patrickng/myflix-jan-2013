Fabricator(:payment) do
  amount { rand(999) }
  reference_id { Faker::Lorem.word }
  user
end
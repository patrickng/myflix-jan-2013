Fabricator(:invitation) do
  recipient_full_name { Faker::Name.name }
  recipient_email_address { Faker::Internet.email }
  recipient_message { Faker::Lorem.paragraph(1) }
  sent_at { Time.zone.now }
  sender { Fabricate(:user) }
  token { Digest::MD5.hexdigest([Time.now, rand].join) }
end
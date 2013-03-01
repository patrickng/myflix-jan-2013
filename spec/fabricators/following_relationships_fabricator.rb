Fabricator(:following_relationship) do
  follower { Fabricate(:user) }
  followed { Fabricate(:user) }
end
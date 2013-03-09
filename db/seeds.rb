# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Categories
Category.delete_all
category1 = Category.create(name: "Uncategorized", description: "Uncategorized shows")
category2 = Category.create(name: "TV Comedies", description: "Funny and humorous TV shows")
category3 = Category.create(name: "TV Dramas", description: "Dramatic TV shows")
category4 = Category.create(name: "Reality TV", description: "TV shows based on real stories and life")


# Videos
Video.delete_all
video1 = Video.create(title: "Monk", description: "Hampered by an odd variety of phobias and obsessive-compulsive tendencies that surfaced after his wife's murder, brilliant San Francisco police detective Adrian Monk (Tony Shalhoub) quits the force and begins working as a consultant on the SFPD's toughest cases. Monk's former superior, Capt. Stottlemeyer (Ted Levine), grudgingly calls on him for help but refuses to let the eccentric ex-cop rejoin the force.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
video2 = Video.create(title: "Family Guy", description: "In Seth MacFarlane's no-holds-barred animated show, buffoonish Peter Griffin and his dysfunctional family experience wacky misadventures, from kidnapping the Pope to being forced to put up scythe-bearing Death for a few days after he breaks his leg.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy_large.jpg")
video3 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama_large.jpg" )
video4 = Video.create(title: "The Walking Dead", description: "In the wake of a zombie apocalypse that desolates the world as we know it, a group of survivors led by police officer Rick Grimes holds on to the hope of humanity by banding together to wage a never-ending fight for their own survival.", small_cover_url: "/tmp/walking_dead.jpg", large_cover_url: "/tmp/walking_dead_large.jpg" )


# Categorizations (join)
Categorization.delete_all
Categorization.create(video_id: video1.id, category_id: category4.id)
Categorization.create(video_id: video1.id, category_id: category3.id)
Categorization.create(video_id: video2.id, category_id: category2.id)
Categorization.create(video_id: video4.id, category_id: category3.id)
Categorization.create(video_id: video3.id, category_id: category2.id)


# Users
User.delete_all
user1 = User.create(full_name: "Patrick Example", email_address: "patrick@example.me", password: "test88")
user2 = User.create(full_name: "Jason Example", email_address: "jason@example.me", password: "hunter2")
user3 = User.create(full_name: "Vicky Example", email_address: "vicky@example.me", password: "shopping531")
user4 = User.create(full_name: "Fanny Example", email_address: "fanny@example.me", password: "pretty42")
user5 = User.create(full_name: "Michael Example", email_address: "michael@example.me", password: "apple69")


# Queue Items
QueueItem.delete_all
QueueItem.create(user_id: user1.id, video_id: video2.id, position: 1)
QueueItem.create(user_id: user1.id, video_id: video3.id, position: 2)
QueueItem.create(user_id: user2.id, video_id: video1.id, position: 1)
QueueItem.create(user_id: user2.id, video_id: video4.id, position: 2)


# Reviews
Review.delete_all
Review.create(user_id: user1.id, video_id: video1.id, rating: 5, max_rating: 5, content: "This movie was a great movie!")
Review.create(user_id: user2.id, video_id: video2.id, rating: 4, max_rating: 5, content: "Family Guy's dry humor and flashback scenes are hilarious!")
Review.create(user_id: user3.id, video_id: video3.id, rating: 3, max_rating: 5, content: "If you like mildly amusing shows, this is it.")
Review.create(user_id: user4.id, video_id: video4.id, rating: 2, max_rating: 5, content: "This show is too unrealistic.")
Review.create(user_id: user5.id, video_id: video1.id, rating: 1, max_rating: 5, content: "This movie was terrible. Do not watch!")


# Following Relationships
FollowingRelationship.create(follower_id: user1.id, followed_id: user2.id)
FollowingRelationship.create(follower_id: user1.id, followed_id: user3.id)
FollowingRelationship.create(follower_id: user1.id, followed_id: user4.id)
FollowingRelationship.create(follower_id: user1.id, followed_id: user5.id)


# Invitations
Invitation.create(sender_id: user1.id, recipient_full_name: "Jane Hoo", recipient_email_address: "jane@example.com", recipient_message: "Hey this was the site I was talking about.", sent_at: Time.zone.now, token: "asdf")
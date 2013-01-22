# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "TV Comedies", description: "Funny and humorous TV shows")
Category.create(name: "TV Dramas", description: "Dramatic TV shows")
Category.create(name: "Reality TV", description: "TV shows based on real stories and life")

Video.create(title: "Monk", description: "Hampered by an odd variety of phobias and obsessive-compulsive tendencies that surfaced after his wife's murder, brilliant San Francisco police detective Adrian Monk (Tony Shalhoub) quits the force and begins working as a consultant on the SFPD's toughest cases. Monk's former superior, Capt. Stottlemeyer (Ted Levine), grudgingly calls on him for help but refuses to let the eccentric ex-cop rejoin the force.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
Video.create(title: "Family Guy", description: "In Seth MacFarlane's no-holds-barred animated show, buffoonish Peter Griffin and his dysfunctional family experience wacky misadventures, from kidnapping the Pope to being forced to put up scythe-bearing Death for a few days after he breaks his leg.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy_large.jpg")
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama_large.jpg" )
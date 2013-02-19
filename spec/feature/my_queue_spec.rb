require 'spec_helper'

feature "My Queue" do
  background do
    User.create(full_name: "Patrick Example", email_address: "patrick@example.me", password: "test88")
    video1 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama_large.jpg" )
    video2 = Video.create(title: "Family Guy", description: "In Seth MacFarlane's no-holds-barred animated show, buffoonish Peter Griffin and his dysfunctional family experience wacky misadventures, from kidnapping the Pope to being forced to put up scythe-bearing Death for a few days after he breaks his leg.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy_large.jpg")
    category1 = Category.create(name: "Comedy", description: "Hilarity and funniness")
    Categorization.create(video_id: video1.id, category_id: category1.id)
    Categorization.create(video_id: video2.id, category_id: category1.id)
  end

  scenario "add video to queue" do
    visit home_path
    fill_in "Email Address:", with: "patrick@example.me"
    fill_in "Password", with: "test88"
    click_button "Sign in"
    find(:xpath, "//a/img[@alt='Futurama']/..").click
    click_on "+ My Queue"
    page.should have_content "Futurama"
  end

  scenario "video link on queue page goes to correct video" do
    visit my_queue_path
    fill_in "Email Address:", with: "patrick@example.me"
    fill_in "Password", with: "test88"
    click_button "Sign in"
    find(:xpath, "//a/img[@alt='Futurama']/..").click
    click_on "+ My Queue"
    click_on "Futurama"
    page.should have_content "Futurama"
  end

  scenario "video show page does not display add to queue link" do
    visit my_queue_path
    fill_in "Email Address:", with: "patrick@example.me"
    fill_in "Password", with: "test88"
    click_button "Sign in"
    find(:xpath, "//a/img[@alt='Futurama']/..").click
    click_on "+ My Queue"
    click_on "Futurama"
    page.should_not have_content "+ My Queue"
  end

  scenario "adding multiple videos to queue" do
    visit home_path
    fill_in "Email Address:", with: "patrick@example.me"
    fill_in "Password", with: "test88"
    click_button "Sign in"
    find(:xpath, "//a/img[@alt='Futurama']/..").click
    click_on "+ My Queue"
    click_on "Videos"
    find(:xpath, "//a/img[@alt='Family_guy']/..").click
    click_on "+ My Queue"
    page.should have_content "Futurama"
    page.should have_content "Family Guy"
  end

  scenario "reordering video in queue" do
    visit home_path
    fill_in "Email Address:", with: "patrick@example.me"
    fill_in "Password", with: "test88"
    click_button "Sign in"
    find(:xpath, "//a/img[@alt='Futurama']/..").click
    click_on "+ My Queue"
    click_on "Videos"
    find(:xpath, "//a/img[@alt='Family_guy']/..").click
    click_on "+ My Queue"
    within("tr:nth-child(1) td:first") do
      fill_in "queue_items[1][position]", with: 2
    end
    within("tr:nth-child(2) td:first") do
      fill_in "queue_items[2][position]", with: 1
    end
    click_on "Update Instant Queue"
    find("tr:nth-child(1) td:nth-child(2)").should have_content "Family Guy"
    find("tr:nth-child(2) td:nth-child(2)").should have_content "Futurama"
  end

end
require 'spec_helper'

feature 'Social Network' do

  given(:bob) { Fabricate(:user, full_name: "Bob Example") }
  given(:mike) { Fabricate(:user, full_name: "Mike Example") }
  given(:comedy) { Fabricate(:category, name: "Comedy") }
  given(:futurama) { Fabricate(:video, title: "Futurama") }
  given(:family_guy) { Fabricate(:video, title: "Family Guy") }

  background do
    Fabricate(:categorization, category: comedy, video: futurama)
    Fabricate(:categorization, category: comedy, video: family_guy)
    Fabricate(:review, user: mike, video: futurama)
  end

  scenario "following and unfollowing users" do

    sign_in(bob)
    select_video(futurama)
    select_user_review(mike)
    follow_user(mike)

    page.should have_content "Mike Example"
    
    unfollow_user(mike)
    page.should_not have_content "Mike Example"

  end
end

def select_video(video)
  visit home_path
  find("section.content a[href='#{video_path(video)}']").click
end

def select_user_review(user)
  click_link "#{user.full_name}"
end

def follow_user(user)
  click_link "Follow"
end

def unfollow_user(user)
  find(:xpath, "//tr[contains(.,'#{user.full_name}')]/td/a/i/..").click
end
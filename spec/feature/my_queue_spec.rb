# require 'spec_helper'

# feature "My Queue" do

#   given(:mike) { Fabricate(:user, full_name: "Mike Example") }
#   given(:comedy) { Fabricate(:category, name: "Comedy") }
#   given(:futurama) { Fabricate(:video, title: "Futurama") }
#   given(:family_guy) { Fabricate(:video, title: "Family Guy") }

#   background do
#     Categorization.create(category_id: comedy.id, video_id: futurama.id)
#     Categorization.create(category_id: comedy.id, video_id: family_guy.id)
#   end

#   scenario "adding and reordering videos in queue" do
    
#     log_in(mike)

#     add_video_to_queue(futurama)

#     page.should have_content "Futurama"
#     click_link "Futurama"
    
#     page.should have_content "Futurama"
#     page.should_not have_content "+ My Queue"

#     add_video_to_queue(family_guy)
#     set_position(family_guy, 1)
#     set_position(futurama, 2)

#     click_button "Update Instant Queue"
    
#     find("tr:nth-child(1) td:nth-child(2)").should have_content "Family Guy"
#     find("tr:nth-child(2) td:nth-child(2)").should have_content "Futurama"
#     find(:xpath, "//tr[contains(.,'Family Guy')]//input")["value"].should == 1
#     find(:xpath, "//tr[contains(.,'Futurama')]//input")["value"].should == 1
#   end

# end

# def set_position(video, position)
#   video_id = page.find(:xpath, "//tr[contains(.,'#{video.title}')]//input")['id']
#   fill_in video_id, with: position.to_s
# end

# def add_video_to_queue(video)
#   visit home_path
#   find("section.content a[href='#{video_path(video)}']").click
#   click_link "+ My Queue"
# end

# def remove_queue_item(video)
#   video_id = page.find(:xpath, "//tr[contains(.,'#{video.title}')]//input")['id']
#   find(:xpath, "//a[href='/queue_items/#{video_id}']").click
# end

require 'spec_helper'

feature 'user interacts with the queue' do

  given(:joe) { Fabricate(:user) }
  given(:comedy) { Fabricate(:category, name: "Comedy") }
  given(:monk) { Fabricate(:video, title: 'Monk', description: "SF detective") }
  given(:futurama) { Fabricate(:video, title: 'Futurama') }
  given(:family_guy) { Fabricate(:video, title: 'Family Guy') }

  background do
    Categorization.create(category_id: comedy.id, video_id: monk.id)
    Categorization.create(category_id: comedy.id, video_id: futurama.id)
    Categorization.create(category_id: comedy.id, video_id: family_guy.id)
  end

  scenario 'adding and reordering videos in the queue' do
    sign_in(joe)

    add_video_to_queue(monk)

    page.should have_content "Monk"
    click_link("Monk")

    page.should have_content "Monk"
    page.should have_content "SF detective"
    page.should_not have_content "+ My Queue"

    visit my_queue_path

    # add_video_to_queue(futurama)
    # add_video_to_queue(family_guy)

    binding.pry

    # set_position(family_guy, 3)
    # set_position(futurama, 1)
    set_position(monk, 1)

    click_button 'Update Instant Queue'

    page.find(:xpath, "//tr[contains(.,'Monk')]//input")['value'].should == '1'
    # page.find(:xpath, "//tr[contains(.,'Monk')]//input")['value'].should == '2'
    # page.find(:xpath, "//tr[contains(.,'Family Guy')]//input")['value'].should == '3'
  end
end

def add_video_to_queue(video)
  visit home_path
  find("section.content a[href='#{video_path(video)}']").click
  click_link("+ My Queue")
end

def set_position(video, position)
  video_id = page.find(:xpath, "//tr[contains(.,'#{video.title}')]//input")['id']
  fill_in video_id, with: position.to_s
end
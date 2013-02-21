require 'spec_helper'

feature "My Queue" do

  given(:mike) { Fabricate(:user, full_name: "Mike Example") }
  given(:comedy) { Fabricate(:category, name: "Comedy") }
  given(:futurama) { Fabricate(:video, title: "Futurama") }
  given(:family_guy) { Fabricate(:video, title: "Family Guy") }

  background do
    Categorization.create(category_id: comedy.id, video_id: futurama.id)
    Categorization.create(category_id: comedy.id, video_id: family_guy.id)
  end

  scenario "adding and reordering videos in queue" do
    
    sign_in(mike)

    add_video_to_queue(futurama)

    page.should have_content "Futurama"
    click_link "Futurama"
    
    page.should have_content "Futurama"
    page.should_not have_content "+ My Queue"

    add_video_to_queue(family_guy)

    set_position(family_guy, 1)
    set_position(futurama, 2)

    click_button "Update Instant Queue"
    
    find("tr:nth-child(1) td:nth-child(2)").should have_content "Family Guy"
    find("tr:nth-child(2) td:nth-child(2)").should have_content "Futurama"
    find(:xpath, "//tr[contains(.,'Family Guy')]/td/input")["value"].should == 1.to_s
    find(:xpath, "//tr[contains(.,'Futurama')]/td/input")["value"].should == 2.to_s
  end

end

def set_position(video, position)
  video_id = page.find(:xpath, "//tr[contains(.,'#{video.title}')]/td/input")['id']
  fill_in video_id, with: position.to_s
end

def add_video_to_queue(video)
  visit home_path
  find("section.content a[href='#{video_path(video)}']").click
  click_link "+ My Queue"
end

def remove_queue_item(video)
  video_id = page.find(:xpath, "//tr[contains(.,'#{video.title}')]/td/input")['id']
  find(:xpath, "//a[href='/queue_items/#{video_id}']").click
end
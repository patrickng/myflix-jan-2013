require 'spec_helper'

feature "Admin Add Video" do
  given(:user) { Fabricate(:user) }
  given(:admin) { Fabricate(:user, admin: true) }
  given!(:comedy) { Fabricate(:category) }

  scenario "admin goes to new_admin_video path, fills out form, adds video" do
  	sign_in(admin)
  	visit new_admin_video_path
  	save_and_open_page
  end

  scenario "user goes to new_admin_video_path, raise error" do

  end
end
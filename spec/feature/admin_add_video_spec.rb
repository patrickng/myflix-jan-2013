require 'spec_helper'

feature "Admin Add Video" do
  given(:user) { Fabricate(:user) }
  given(:admin) { Fabricate(:user, admin: true) }

  scenario "admin goes to new_admin_video path, fills out form, adds video" do

  end

  scenario "user goes to new_admin_video_path, raise error" do

  end
end
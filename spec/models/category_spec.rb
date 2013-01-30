require 'spec_helper'

describe Category do
  it "saves a category" do
    category = Category.new(name: "Drama", description: "This is the drama category")

    category.save
    Category.first.name.should == "Drama"
  end

  describe "associations" do
    it { should have_many(:videos) }
    it { should have_many(:videos).through(:categorizations) }
  end

  describe "recent videos" do
    it "should display 6 most recent videos in reverse chronological order" do

      # 7.times do |n|
      #   video = Video.create(title: "video #{n}", description: "video #{n} description")
      # end

      video1 = Video.create(title: "video 1", description: "video 1 description")
      video2 = Video.create(title: "video 2", description: "video 2 description")
      video3 = Video.create(title: "video 3", description: "video 3 description")
      video4 = Video.create(title: "video 4", description: "video 4 description")
      video5 = Video.create(title: "video 5", description: "video 5 description")
      video6 = Video.create(title: "video 6", description: "video 6 description")
      video7 = Video.create(title: "video 7", description: "video 7 description")

      Category.recent_videos.should == (video2..video7).to_a.reverse
    end

    it "should display all videos when there is less than 6 videos"
  end
end
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

      category = Category.new(name: "uncategorized", description: "test")

      video1 = Video.create(title: "video 1", description: "video 1 description")
      category.videos << video1
      video2 = Video.create(title: "video 2", description: "video 2 description")
      category.videos << video2
      video3 = Video.create(title: "video 3", description: "video 3 description")
      category.videos << video3
      video4 = Video.create(title: "video 4", description: "video 4 description")
      category.videos << video4
      video5 = Video.create(title: "video 5", description: "video 5 description")
      category.videos << video5
      video6 = Video.create(title: "video 6", description: "video 6 description")
      category.videos << video6
      video7 = Video.create(title: "video 7", description: "video 7 description")
      category.videos << video7
      category.save

      category.recent_videos.should == [video7, video6, video5, video4, video3, video2]
    end

    it "should display all videos when there is less than 6 videos" do
      category = Category.new(name: "uncategorized", description: "test")

      video1 = Video.create(title: "video 1", description: "video 1 description")
      category.videos << video1
      video2 = Video.create(title: "video 2", description: "video 2 description")
      category.videos << video2
      video3 = Video.create(title: "video 3", description: "video 3 description")
      category.videos << video3
      video4 = Video.create(title: "video 4", description: "video 4 description")
      category.videos << video4
      video5 = Video.create(title: "video 5", description: "video 5 description")
      category.videos << video5
      category.save

      category.recent_videos.should == [video5, video4, video3, video2, video1]
    end

    it "should display all videos when there is 6 videos" do
      category = Category.new(name: "uncategorized", description: "test")

      video1 = Video.create(title: "video 1", description: "video 1 description")
      category.videos << video1
      video2 = Video.create(title: "video 2", description: "video 2 description")
      category.videos << video2
      video3 = Video.create(title: "video 3", description: "video 3 description")
      category.videos << video3
      video4 = Video.create(title: "video 4", description: "video 4 description")
      category.videos << video4
      video5 = Video.create(title: "video 5", description: "video 5 description")
      category.videos << video5
      video6 = Video.create(title: "video 6", description: "video 6 description")
      category.videos << video6
      category.save

      category.recent_videos.should == [video6, video5, video4, video3, video2, video1]
    end
  end
end
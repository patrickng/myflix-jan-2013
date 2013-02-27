require 'spec_helper'

describe Video do
  describe "associations" do
    it { should have_many(:categories) }
    it { should have_many(:categories).through(:categorizations) }
    it { should have_many(:reviews) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "search results" do
    before(:each) do
      @video1 = Fabricate(:video, title: "The Walking Dead")
      @video2 = Fabricate(:video, title: "The Crawling Dead")
    end

    it "should return empty array when search has no results" do
      Video.search_by_title("The Running Dead").should == []
    end

    it "should return array with items when search has results" do
      Video.search_by_title("dead").should include(@video1, @video2)
    end

    it "should return empty array when there is no search input" do
      Video.search_by_title("").should == []
    end
  end

  describe "#rating" do
    let(:video) { Fabricate(:video) }

    it "gives rating nil without reviews" do
      video.rating.should == 0.0
    end

    it "gives average rating of one review" do
      video.reviews.create(rating: 5, max_rating: 5, content: "test")
      video.rating.should == 5.0
    end

    it "gives average rating of reviews" do
      video.reviews.create(rating: 4, max_rating: 5, content: "test")
      video.reviews.create(rating: 1, max_rating: 5, content: "test")
      video.rating.should == 2.5
    end

    it "gives average rating of reviews with one decimal" do
      video.reviews.create(rating: 4, max_rating: 5, content: "test")
      video.reviews.create(rating: 1, max_rating: 5, content: "test")
      video.reviews.create(rating: 5, max_rating: 5, content: "test")
      video.rating.should == 3.3
    end
  end
end
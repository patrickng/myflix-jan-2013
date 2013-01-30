require 'spec_helper'

describe Video do

  describe "associations" do
    it { should have_many(:categories) }
    it { should have_many(:categories).through(:categorizations) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "search results" do
    it "should return empty array when search has no results" do
      Video.create(title: "The Walking Dead", description: "A group of survivors try to survive the zombie apocalypse.")
      Video.search_by_title("The Running Dead").should == []
    end

    it "should return array with items when search has results" do
      video1 = Video.create(title: "The Walking Dead", description: "A group of survivors try to survive the walkers.")
      video2 = Video.create(title: "The Crawling Dead", description: "A group of survivors try to survive the crawlers.")
      Video.search_by_title("The Walking Dead").should include(video1)
    end
  end

end
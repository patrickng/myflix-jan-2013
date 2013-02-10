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
end
require 'spec_helper'

describe Video do
  before do
    @video = Video.new(
      title: "The Simpsons", 
      description: "Funny cartoon about the Simpsons family", 
      small_cover_url: "/tmp/simpsons.jpg", 
      large_cover_url: "/tmp/simpsons_large.jpg"
    )
    @video.save
  end

  # it "should have a title" do
  #   Video.first.title?.should be_true
  # end

  # it "should have a description" do
  #   Video.first.description?.should be_true
  # end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should have_many(:categories) }
  it { should have_many(:categories).through(:categorizations) }
end
require 'spec_helper'

describe Category do
  it "saves a category" do
    category = Category.new(name: "Drama", description: "This is the drama category")

    category.save
    Category.first.name.should == "Drama"
  end

  it { should have_many(:videos) }
  it { should have_many(:videos).through(:categorizations) }
end
require 'spec_helper'

describe Review do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end

  describe "validations" do
    it { should validate_presence_of(:review) }
    it { should validate_presence_of(:rating) }
  end
end
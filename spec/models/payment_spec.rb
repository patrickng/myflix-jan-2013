require 'spec_helper'

describe Payment do
  describe "associations" do
    it { should belong_to(:user) }
  end
end

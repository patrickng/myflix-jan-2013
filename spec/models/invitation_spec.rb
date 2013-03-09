require 'spec_helper'

describe Invitation do

  it { should respond_to(:generate_invitation_token) }

  describe "associations" do
    it { should have_one(:recipient) }
    it { should belong_to(:sender) }
  end

  describe "validations" do
    it { should validate_presence_of(:recipient_full_name) }
    it { should validate_presence_of(:recipient_email_address) }
    it { should validate_uniqueness_of(:recipient_email_address) }
    it { should validate_presence_of(:recipient_message) }
  end
end

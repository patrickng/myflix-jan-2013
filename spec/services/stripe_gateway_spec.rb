require 'spec_helper'

describe StripeGateway::Customer do
  before do
    StripeGateway.set_api_key
  end

  let(:token) { Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 3,
        exp_year: 2016,
        cvc: 314
      }
    ).id 
  }

  context "with valid credit card" do
    let(:card_number) { "4242424242424242" }
    let(:plan) { "myflix-unlimited" }
    let(:email_address) { "test@test.com" }

    it "charges the card successfully" do
      response = StripeGateway::Customer.create(email: email_address, plan: plan, card: token)
      response.should be_subscribed
    end
  end

  context "with invalid credit card" do
    let(:card_number) { "4000000000000002" }
    let(:plan) { "myflix-unlimited" }
    let(:email_address) { "test@test.com" }

    let(:response) { StripeGateway::Customer.create(email: email_address, plan: plan, card: token) }

    it "does not charge the card" do
      response.should_not be_subscribed
    end

    it "contains an error message" do
      response.error_message.should == "Your card was declined"
    end
  end
end
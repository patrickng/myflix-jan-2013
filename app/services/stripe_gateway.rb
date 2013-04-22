module StripeGateway
  class Customer
    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(options = {})
      StripeGateway.set_api_key
      begin
        response = Stripe::Customer.create(email: options[:email_address], plan: options[:plan], card: options[:card])
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end

    def subscribed?
      status == :success
    end

    def error_message
      response.message
    end
  end

  def self.set_api_key
    Stripe.api_key = Rails.env.production? ? RAILS_ENV['STRIPE_LIVE_API_KEY'] : "sk_test_3VfKfliIRsZ6JebIedsMzXUG"
  end
end
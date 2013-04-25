Stripe.api_key = Rails.env.production? ? RAILS_ENV['STRIPE_LIVE_API_KEY'] : "sk_test_3VfKfliIRsZ6JebIedsMzXUG" # Set your api key

StripeEvent.setup do
  subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    event.class #=> Stripe::Event
    event.type  #=> "charge.failed"
    event.data  #=> { ... }
  end

  subscribe 'customer.created' do |event|
    user = User.find_by_email_address(event.data.object.email)
    user.customer_token = event.data.object.id
    user.save(validate: false)
    payment = Payment.new
    payment.user_id = user.id
    payment.save!
  end

  subscribe 'charge.succeeded' do |event|
    user = User.find_by_customer_token(event.data.object.customer)
    payment = user.payments.last
    payment.amount = event.data.object.amount
    payment.reference_id = event.data.object.id
    payment.save
    UserMailer.delay.payment_successful(user.id)
  end

  subscribe 'charge.failed' do |event|
    user = User.find_by_customer_token(event.data.object.customer)
    UserMailer.delay.payment_failed(user.id)
  end
end
Rails.configuration.stripe = {
    :publishable_key => ENV['stripe_p_key'] ||= Rails.application.credentials.stripe_p_key ,
    :secret_key =>  ENV['stripe_s_key'] ||= Rails.application.credentials.stripe_s_key
    # :publishable_key => 'pk_test_51H6ZGHHtJ9XMkl4Hy70xbacwBBa90sxij3MMOXjiEQi1upTtG2lLw8IWcOw0QjO9DEZLGkBtLFmtT96vJwwKVOEb00FFw7rpiY',
    # :secret_key =>  'sk_test_51H6ZGHHtJ9XMkl4HKfveCbNzIMSpJOYVJKwANE7n23LDDHHfSEqCVJESLtUCkukTnwH909HYUC37SioQp8IfY58P00I3oAan6k'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
#
# Rails.application.credentials.stripe[:test_secret_key]
# Rails.application.credentials.stripe[:test_publishable_key]



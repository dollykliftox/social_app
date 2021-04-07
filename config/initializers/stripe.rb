Rails.configuration.stripe = {
  :publishable_key => 'pk_test_51IbLcdSD2N9cM4lY0T5GWx3xzCFuMdZa8luMXKFiSvIpwlyXyHeWfxQtM6TY0KZ9UxOCscwEtfDmJpKvT11fYaaQ00yDQSGEwj',
  :secret_key      => 'sk_test_51IbLcdSD2N9cM4lYPudqpUYgtgWPpfYQYFaNJXth4S3vLKVwi9VGKDeJbIlBNJoNO5W978K7566leEhDpkMH8r2i00p3Eg1RUN'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
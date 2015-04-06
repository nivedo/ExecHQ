Expedia.setup do |config|
	config.cid = 55505 # your cid once you go live.
	config.api_key = 'k54cudw9k7rytfyef6e8z2pt'
	config.shared_secret = 'ncEF8fUs'
	config.locale = 'en_US' # For Example 'de_DE'. Default is 'en_US'
	config.currency_code = 'USD' # For Example 'EUR'. Default is 'USD'
	config.minor_rev = 28 # between 4-28 as of Jan 2015. If not set, 4 is used by EAN.
  # optional configurations...
  config.timeout = 5 # read timeout in sec
  config.open_timeout = 5 # connection timeout in sec
end

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Demo_session',
  :secret      => '9980f0533f517a7076e0a587f0b888c8670d50a9e6a29bb5f2a0689e223b029ee7d1c03af67b28be62e688dfc6354706be76170c64cd3300af6dc3aae426f55b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

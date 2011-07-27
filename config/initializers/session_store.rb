# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_recipes_session',
  :secret      => '9fb294713e2233754d94e674c1018edc8cbb26aad544d89c627b3206ef9c60b2b3909b74c0b1682da470aadb308f2b37079633fbd110fa39535731ad9f3d8fed'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

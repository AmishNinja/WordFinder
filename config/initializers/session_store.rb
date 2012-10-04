# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_words_session',
  :secret      => '965d5320c214fc6d1df6116053a27417e31bdba5a3569b357ab22985c1218e9952dd100154ccd3611a1120786a028ba9cb81deba172bfe4e98ec2518526a807b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

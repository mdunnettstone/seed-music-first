# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_seed-music-first_session', domain: :all, tld_length: (Rails.env.production? ? 3 :2)

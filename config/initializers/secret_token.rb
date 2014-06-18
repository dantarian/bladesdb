# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Blades::Application.config.secret_key_base = ENV["SECRET_KEY_BASE"] || '61514ef0189fb8de2add403b6056c7b6601918fdd2f90474ff0144a58e893f0aa67a2e43d7236529f8b368e9c56f497e7b100997f01708956c2c19321a8ac360'

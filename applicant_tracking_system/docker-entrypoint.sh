#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

# Run database setup
rails db:create
rails db:migrate
rails db:seed

# Start the Rails server
exec "$@"
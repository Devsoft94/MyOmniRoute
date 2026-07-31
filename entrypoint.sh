#!/bin/sh
set -e

# 1. Restore database from Filebase S3 if a snapshot exists
echo "Restoring database from Filebase..."
litestream restore -if-replica-exists /app/data/omniroute.db

# 2. Run Litestream replication in the background
echo "Starting Litestream replication..."
litestream replicate -config /etc/litestream.yml &

# 3. Start OmniRoute server
echo "Starting OmniRoute server..."
exec node server.js

#!/bin/bash

# Execute all scripts in /docker-entrypoint.d
for f in /docker-entrypoint.d/*.sh; do
  bash "$f" -H
done

# Execute the command passed to the container
exec "$@"

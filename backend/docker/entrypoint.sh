#!/bin/sh
set -eu

if [ -d "prisma/migrations" ] && [ "$(ls -A prisma/migrations 2>/dev/null || true)" ]; then
  npx prisma migrate deploy
else
  npx prisma db push
fi

if [ "${RUN_SEED:-false}" = "true" ]; then
  npx prisma db seed
fi

exec node dist/main.js

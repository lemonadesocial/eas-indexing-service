#!/bin/sh
set -e

export DATABASE_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

# Wait for PostgreSQL to be available
echo "Connecting to database..."
until PGPASSWORD=$DB_PASSWORD psql -p "$DB_PORT" -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  echo "PostgreSQL not ready, waiting..."
  sleep 2
done

# the schema is already generated in build phase, so we can skip the generate step
echo "Pushing database..."
npx prisma db push --skip-generate

echo "Starting application..."
yarn start

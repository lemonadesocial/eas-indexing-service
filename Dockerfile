FROM node:18-alpine as app

WORKDIR /app

COPY . .

COPY entrypoint.sh /app/entrypoint.sh
RUN apk update && apk add --no-cache openssl postgresql-client
RUN chmod +x /app/entrypoint.sh
RUN yarn install

# we can generate the schema here without database URL
RUN SKIP_PRISMA_VERSION_CHECK=true npx prisma generate

ENTRYPOINT ["/app/entrypoint.sh"]
EXPOSE 4000

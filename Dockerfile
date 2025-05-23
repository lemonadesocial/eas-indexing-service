FROM node:20-alpine3.16 as app
WORKDIR /app

COPY . .

COPY entrypoint.sh /app/entrypoint.sh
RUN apk update && apk add --no-cache postgresql-client
RUN chmod +x /app/entrypoint.sh
RUN yarn install

# we can generate the schema here without database URL
RUN yarn prisma generate

ENTRYPOINT ["/app/entrypoint.sh"]
EXPOSE 4000

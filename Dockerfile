# syntax=docker/dockerfile:1

FROM node:17-alpine AS DEV

WORKDIR /app

COPY ["package.json", "yarn.lock", "./"]
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn run build

FROM node:17-alpine AS PROD

WORKDIR /app

COPY --from=DEV /app/dist ./dist
COPY --from=DEV /app/package.json ./package.json
COPY --from=DEV /app/yarn.lock ./yarn.lock
RUN yarn install --frozen-lockfile --production

CMD [ "yarn", "run", "start:prod" ]

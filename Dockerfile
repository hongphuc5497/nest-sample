# syntax=docker/dockerfile:1

FROM node:17-slim

WORKDIR /usr/src/app

COPY ["package.json", "yarn.lock", "./"]

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn run build

EXPOSE 8000

CMD [ "yarn", "run", "start:prod" ]

# Build stage
FROM node:16.13.1 AS build

## Declare env vars
ARG HEARTBEAT_SERVER="http://localhost:3000"
ENV REACT_APP_HEARTBEAT_SERVER=$HEARTBEAT_SERVER

## Create app directory
WORKDIR /app

## Install app dependencies
COPY package*.json ./
RUN npm i --only=production

## Bundle app source
COPY ./src ./src
COPY ./public ./public

## Create production build
RUN npm run build



# Run stage
FROM node:16.13.1

## Install serve
RUN npm i -g serve

## Switch to less privileged user
USER node

## Create app directory
WORKDIR /app

## Copy app
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/build ./build

## Execute app
ENTRYPOINT [ "serve", "-s", "build", "-l", "3001"]

## Expose port
EXPOSE 3001
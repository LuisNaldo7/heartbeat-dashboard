FROM node:lts

ARG HEARTBEAT_SERVER="http://localhost:3000"
ENV REACT_APP_HEARTBEAT_SERVER=$HEARTBEAT_SERVER

# Create app directory
WORKDIR /app

# Bundle app source
COPY ./src ./src
COPY ./public ./public
COPY package*.json ./

# Install app dependencies
RUN npm i --only=prod

# Create production build
RUN npm run build

# Install serve
RUN npm i -g serve

EXPOSE 3001
ENTRYPOINT [ "serve", "-s", "build", "-l", "3001"]
FROM node:16.13.1

ARG HEARTBEAT_SERVER="http://localhost:3000"
ENV REACT_APP_HEARTBEAT_SERVER=$HEARTBEAT_SERVER

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm i --only=production

# Bundle app source
COPY ./src ./src
COPY ./public ./public

# Create production build
RUN npm run build

# Install serve
RUN npm i -g serve

EXPOSE 3001
ENTRYPOINT [ "serve", "-s", "build", "-l", "3001"]
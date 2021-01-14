FROM node:lts

ENV REACT_APP_HEARTBEAT_SERVER="http://localhost:3000"

# Create app directory
WORKDIR /app

# Bundle app source
COPY ./src ./src
COPY ./public ./public
COPY package*.json ./

# Install app dependencies
RUN npm install

RUN npm run build

EXPOSE 3001
CMD [ "npm", "start"]
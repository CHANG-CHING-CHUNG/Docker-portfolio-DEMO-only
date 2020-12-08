FROM node:alpine

RUN apk update && apk add bash

# Create app directory
WORKDIR /var/node/node-Lottery


# Install app dependencies
COPY ./node-Lottery/package.json /var/node/node-Lottery
RUN npm install

# Bundle app source
COPY ./node-Lottery /var/node/node-Lottery


EXPOSE 3000


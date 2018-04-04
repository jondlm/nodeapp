# ------------------------------------------------------------------------------
# BUILD
# ------------------------------------------------------------------------------

FROM node:6-alpine as builder

RUN mkdir /code
WORKDIR /code

# Use package.json/yarn.lock as a cache layer
COPY package.json yarn.lock ./

# Install Dependencies
RUN yarn install --pure-lockfile

# Copy all app files, respecting the `.dockerignore` file
COPY . .

RUN true

EXPOSE 80
ENV NODE_ENV=production

CMD node index.js

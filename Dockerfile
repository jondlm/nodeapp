# ------------------------------------------------------------------------------
# BUILD
# ------------------------------------------------------------------------------

FROM node:6-alpine as builder

RUN mkdir /builder
WORKDIR /builder

# Use package.json/yarn.lock as a cache layer
COPY package.json yarn.lock ./

# Install Dependencies
RUN yarn install --pure-lockfile

# Copy all app files, respecting the `.dockerignore` file
COPY . .

RUN npm prune --production

# ------------------------------------------------------------------------------
# RUN
# ------------------------------------------------------------------------------

FROM node:6-alpine

RUN mkdir /runtime
WORKDIR /runtime

# Directories
COPY --from=builder /builder/index.js /runtime/index.js
COPY --from=builder /builder/node_modules /runtime/node_modules

EXPOSE 80
ENV NODE_ENV=production

CMD node index.js

# Dev dependencies
FROM node:19.2-alpine3.16 as dependencies
WORKDIR /app 
COPY package.json ./
RUN npm install

# Build and tests
FROM node:19.2-alpine3.16 as builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN npm run test

# Prod dependencies
FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod


# Extecute app
FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks
# run app command
CMD [ "node", "app.js" ]






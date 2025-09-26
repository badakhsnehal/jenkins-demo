# Stage 1: Build
FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Run
FROM node:16-alpine
WORKDIR /app
COPY --from=builder /app/build ./build

ARG BUILD_ID
ARG GIT_COMMIT

ENV BUILD_ID=${BUILD_ID}
ENV GIT_COMMIT=${GIT_COMMIT}

CMD ["node", "server.js"]

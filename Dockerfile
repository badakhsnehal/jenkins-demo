FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ARG BUILD_ID
ARG GIT_COMMIT

ENV BUILD_ID=${BUILD_ID}
ENV GIT_COMMIT=${GIT_COMMIT}

EXPOSE 8080

CMD ["node", "server.js"]

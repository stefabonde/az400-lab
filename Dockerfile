FROM node:22-alpine AS test
WORKDIR /app
COPY package.json ./
COPY src ./src
RUN npm test

FROM node:22-alpine
WORKDIR /app
COPY package.json ./
COPY --from=test /app/src ./src
ENV PORT=3000
EXPOSE 3000
USER node
CMD ["node", "src/server.js"]

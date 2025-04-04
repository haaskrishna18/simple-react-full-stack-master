# Stage 1: Build the React client
FROM node:18-alpine as client-builder

WORKDIR /client
COPY client/package*.json ./
RUN npm install
COPY client/ .
RUN npm run build


# Stage 2: Build the Express server
FROM node:18-alpine as server

WORKDIR /app

COPY server/package*.json ./
RUN npm install

# Copy server source code
COPY server/ .

# Copy built React files from client-builder into the server's public folder
COPY --from=client-builder /client/build ./public

EXPOSE 5000
CMD ["npm", "start"]

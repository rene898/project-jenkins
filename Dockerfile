# Use a lightweight Node image to build the app
FROM node:20-slim AS build

# Create app directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy and build the application
COPY . .
RUN npm run build

# Use an Nginx image to serve the app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
# Step 1: Build the React application
FROM node:20-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application files
COPY . .

# Build the React application
RUN npm run build

# Step 2: Serve the React application
FROM nginx:alpine

# Copy the build artifacts from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
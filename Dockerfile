# Use a lightweight Node image to build the app 
FROM node:18-latest AS build

#create a directory 
WORKDIR /app

#Install dependencies
COPY package*.json ./
RUN npm ci --legacy-peer-deps

#Copy and build the app
COPY . .
RUN npm run build

# Use an Nginx image to serve the app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

# Set the default command to run Jenkins
CMD ["nginx", "-g", "daemon off;"]
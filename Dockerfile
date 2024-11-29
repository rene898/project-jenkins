# Use a lightweight Node image to build the app 
FROM node:16-alpine AS build

#create a directory 
WORKDIR /app

#Install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

#Copy and build the app
COPY . .
RUN npm run build

# Use an Nginx image to serve the app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

# Set the default command to run Jenkins
CMD ["nginx", "-g", "daemon off;"]
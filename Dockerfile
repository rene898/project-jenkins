# Build phase
FROM node:18-alpine AS build

WORKDIR /app

# Actualizar NPM y limpiar caché
RUN npm install -g npm@latest
COPY package*.json ./
RUN sudo rm -rf node_modules && npm cache clean --force
RUN npm install --legacy-peer-deps

# Copiar código y construir la aplicación
COPY . .
RUN npm run build

# Run phase
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

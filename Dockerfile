# --- Étape 1 : compiler l'application Angular ---
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
RUN ls -R /app/dist
# --- Étape 2 : servir les fichiers statiques avec nginx ---
FROM nginx:alpine
COPY --from=build /app/dist/TD-Agile-Front/browser /usr/share/nginx/html
EXPOSE 80

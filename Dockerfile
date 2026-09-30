# Alternate Dokploy path. Nixpacks (nixpacks.toml) is the default build.
# This image builds the static Astro site and serves dist with nginx.
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80

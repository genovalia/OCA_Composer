FROM node:20-alpine3.19 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm cache clean --force
COPY . .
EXPOSE 3000
RUN npm run build

FROM nginxinc/nginx-unprivileged AS production
#COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]

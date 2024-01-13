#step1 build app
FROM node:alpine3.18 as build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run start

FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -f *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
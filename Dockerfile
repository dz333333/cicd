FROM node:latest as compile
WORKDIR /usr/src/app/
COPY package.json ./
RUN npm i --registry=https://registry.npm.taobao.org
COPY . .
RUN npm run build

FROM nginx
COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=compile /usr/src/app/build /usr/share/nginx/html/
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
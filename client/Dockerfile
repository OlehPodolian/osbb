# Stage 0: compile angular frontend
FROM node:latest as build

ARG APP_PATH=/app/

WORKDIR ${APP_PATH}

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

COPY . ${APP_PATH}/

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i --no-optional
RUN npm i net -S

EXPOSE 80

RUN npm rebuild node-sass
#RUN npm run build --${CONFIGURATION} --aot
RUN npm run build --prod --aot

# Stage 1: serve app with nginx server
FROM nginx:latest
## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=build /app/dist/ng-monster /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]

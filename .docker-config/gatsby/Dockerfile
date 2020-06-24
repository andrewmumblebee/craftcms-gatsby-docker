FROM node:alpine

# Also exposing VSCode debug ports
EXPOSE 80 9000 9929 9230

RUN \
  apk add --no-cache python make g++ && \
  apk add vips-dev fftw-dev --update-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  --repository http://dl-3.alpinelinux.org/alpine/edge/main \
  && rm -fR /var/cache/apk/*

RUN npm install -g gatsby-cli nodemon

# Clean builds
WORKDIR /app
RUN rm node_modules -rf
COPY ./gatsby/package.json .
COPY ./gatsby/yarn.lock .
RUN yarn cache clean && yarn install
CMD ["yarn", "develop-docker", "-H", "0.0.0.0", "-p", "80"]

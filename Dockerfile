FROM node:13-alpine3.10

RUN apk add zip
RUN yarn add @tryghost/admin-api @actions/exec

COPY deploy /usr/bin/

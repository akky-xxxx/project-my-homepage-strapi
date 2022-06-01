FROM node:16.15.0-alpine
WORKDIR ./app
COPY ../../. .

RUN yarn --frozen-lockfile \
    && rm -rf /usr/local/share/.cache \
    && rm -rf /root/.npm

WORKDIR ./packages/service-strapi

ENV NODE_ENV=production

RUN mkdir public && yarn build

CMD ["yarn", "start"]

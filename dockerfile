#Parte UM do multiplo estagio

FROM node:18 AS build

WORKDIR /usr/src/app

COPY package.json .yarnrc.yml ./

COPY .yarn ./.yarn

RUN yarn

COPY . .

RUN yarn run build

RUN yarn workspaces focus --production && yarn cache clean

#Parte DOIS do multiplo estagio

FROM node:18-alpine3.19

WORKDIR /usr/src/app


COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/yarn.lock ./yarn.lock
COPY --from=build /usr/src/app/.yarn ./.yarn         
COPY --from=build /usr/src/app/.yarnrc.yml ./.yarnrc.yml
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist
RUN yarn --version
RUN corepack enable && corepack prepare yarn@stable --activate
RUN yarn --version

EXPOSE 3000

CMD ["yarn", "run", "start:prod"]
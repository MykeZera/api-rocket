FROM node:18-alpine3.19

WORKDIR /usr/src/app

COPY package.json .yarnrc.yml ./

COPY .yarn ./.yarn

RUN yarn

COPY . .

RUN yarn run build

EXPOSE 3000

CMD ["yarn", "run", "start"]
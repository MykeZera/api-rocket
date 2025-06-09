FROM node:18-slim

WORKDIR /usr/src/app

COPY package.json ./

RUN yarn --ignore-engines

COPY . .

RUN yarn run build

EXPOSE 3000

CMD ["yarn", "run", "start"]
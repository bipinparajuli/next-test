FROM node:alpine as base

WORKDIR /app

COPY  package*.json next.config.js tsconfig.json ./

RUN npm i --production

COPY src ./src

COPY public ./public

RUN npm run build


FROM node:alpine as prod

WORKDIR /app

COPY --from=base /app/package*.json ./
COPY --from=base /app/.next ./.next
COPY --from=base /app/public ./.public
RUN npm install next

CMD ["npm","run","start"]
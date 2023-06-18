# FROM node:alpine as front
FROM node:19.2.0 as front
WORKDIR /app
# COPY . .
COPY ./bu72_front/code .
# VOLUME "./bu72_front/code:/app"

RUN npm install
# # CMD [ "npm install" ]
RUN npm run build
# RUN npm run generate
# CMD [ "npm", "install", "npm run build" , "/node .output/server/index.mjs"]
# RUN node .output/server/index.mjs   
# CMD [ "node .output/server/index.mjs"]
# RUN ls

# # FROM node:lts-alpine
# FROM node:lts-alpine

# ARG RES_DIR=../2304bu_nuxt3

# # устанавливаем простой HTTP-сервер для статики
# # RUN npm install -g http-server

# # делаем каталог 'app' текущим рабочим каталогом
# # WORKDIR /app
# WORKDIR /usr/src/app

# # копируем оба 'package.json' и 'package-lock.json' (если есть)
# # COPY ${RES_DIR}/package*.json ./

# # устанавливаем зависимости проекта
# # RUN npm install

# # копируем файлы и каталоги проекта в текущий рабочий каталог (т.е. в каталог 'app')
# # COPY . .
# # COPY ${RES_DIR}/ .

# # ADD ${RES_DIR} /usr/src/app
# # ADD /code /usr/src/app
# # COPY /bu72_front/code /usr/src/app
# ADD /bu72_front/code /usr/src/app

# # собираем приложение для production с минификацией
# # RUN npm run build
# # RUN npm run generate
# # RUN npm install -g npm@9.6.7

# # RUN npm i
# # # RUN npm run build
# # RUN npm run generate
# RUN npm run build

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

EXPOSE 3000 

ENTRYPOINT ["node", ".output/server/index.mjs"]

# EXPOSE 8080
# # CMD [ "http-server", "dist" ]
# # CMD [ "npm", "install" ]
# # CMD [ "npm", "run" , "generate" ]
# # CMD [ "npm", "run" , "build" ]
# # CMD [ "npm", "run" , "build", "&&", "node .output/server/index.mjs" ]
# # CMD [ "npm", "run" , "build" ]
# CMD ["node .output/server/index.mjs"]
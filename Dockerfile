FROM node:alpine3.18
WORKDIR /app
COPY ./app ./
RUN npm install
EXPOSE 80
CMD [ "node", "index.js" ]
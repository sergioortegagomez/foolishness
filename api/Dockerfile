FROM node

WORKDIR /opt/api

COPY src /opt/api
RUN npm install

EXPOSE 3000

CMD ["node", "index.js"]
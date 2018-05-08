From node:8
RUN mkdir /home/node/.npm-global; \
    mkdir /home/node/.ssb; \
    chown -R node:node /home/node/
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
# get package.json to run npm i
VOLUME /home/node
RUN mkdir -p /app;
WORKDIR /app
COPY package*.json /app/
RUN chown node:node -R /app
USER node
RUN npm i
# copy the rest (for cache)
USER root
COPY bin.js /app/
COPY config /app/config
COPY plugins /app/plugins
RUN chown node:node -R /app -R
USER node
RUN npm run build
ENV appname decent
CMD ["npm","run","start"]

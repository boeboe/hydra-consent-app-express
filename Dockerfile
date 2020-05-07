FROM node:6.1

LABEL name="hydra-consent-app-express"
LABEL description="This is an exemplary consent application that implements ORY Hydra's consent flow. It uses NodeJS and express."
LABEL source-repo="https://github.com/ory/hydra-consent-app-express"
LABEL version=${VERSION}

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV HYDRA_URL="http://localhost:4444"
ENV HYDRA_CLIENT_ID="demo"
ENV HYDRA_CLIENT_SECRET="demo"
ENV NODE_TLS_REJECT_UNAUTHORIZED=0

COPY . /usr/src/app
RUN npm install --silent; exit 0

ENTRYPOINT npm start

EXPOSE 3000

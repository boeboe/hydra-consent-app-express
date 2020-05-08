# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

DOCKER_ACCOUNT=boeboe
APP_NAME=hydra-consent-app-express
TAG=v1.4.6

DOCKER_ENV='-e HYDRA_URL="http://localhost:4444" -e HYDRA_CLIENT_ID="demo" -e HYDRA_CLIENT_SECRET="demo"'

publish: build-clean push  ## Build clean and push container

build:  ## Build container
	docker build --pull -t ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG} --build-arg VERSION=${TAG} .
	docker tag ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG} ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG}
	docker tag ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG} ${DOCKER_ACCOUNT}/${APP_NAME}:latest

build-clean:  ## Build clean container without cache
	docker build --pull --no-cache -t ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG} --build-arg VERSION=${TAG} .
	docker tag ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG} ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG}
	docker tag ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG} ${DOCKER_ACCOUNT}/${APP_NAME}:latest

push:  ## Push docker container
	docker push ${DOCKER_ACCOUNT}/${APP_NAME}:${TAG}
	docker push ${DOCKER_ACCOUNT}/${APP_NAME}:latest

run: build ## Run container locally
	docker run --name=${APP_NAME} -p 3000:8080 ${DOCKER_ENV} ${DOCKER_ACCOUNT}/${APP_NAME}

sh: build ## Run container locally and shell into it
	docker run -i -t --entrypoint /bin/sh --name=${APP_NAME} -p 3000:8080 ${DOCKER_ENV} ${DOCKER_ACCOUNT}/${APP_NAME}

stop: ## Stop and remove running container
	docker stop ${APP_NAME}; docker rm ${APP_NAME}

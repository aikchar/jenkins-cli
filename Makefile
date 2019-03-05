JENKINS_URL ?= NOTSET
export JENKINS_URL

JENKINS_LEADER_ADMIN_USER ?= NOTSET
export JENKINS_LEADER_ADMIN_USER

JENKINS_LEADER_ADMIN_PASSWORD ?= NOTSET
export JENKINS_LEADER_ADMIN_PASSWORD

JENKINS_IP ?= NOTSET
export JENKINS_IP

JENKINS_PORT ?= NOTSET
export JENKINS_PORT

JENKINS_HOST ?= NOTSET
export JENKINS_HOST

KEYSTOREFILE ?= /usr/local/etc/keystore
export KEYSTOREFILE

KEYSTOREPASS ?= IamInsecure
export KEYSTOREPASS

.PHONY: help
help:
	@echo 'make init'
	@echo 'make cli-exec'
	@echo 'make cli-alt-exec'

.PHONY: init
init: jenkins-cli.jar
	pipenv install

jenkins-cli.jar:
	curl -o jenkins-cli.jar $(JENKINS_URL)/jnlpJars/jenkins-cli.jar

.PHONY: cli-exec
cli-exec: cli-up
	pipenv run docker-compose exec cli sh

.PHONY: cli-up
cli-up:
	pipenv run docker-compose up -d cli

.PHONY: cli-stop
cli-stop:
	pipenv run docker-compose stop cli

.PHONY: cli-start
cli-start:
	pipenv run docker-compose start cli

.PHONY: cli-down
cli-down:
	pipenv run docker-compose down cli

.PHONY: cli-alt-exec
cli-alt-exec: cli-alt-up
	pipenv run docker-compose exec cli-alt sh

.PHONY: cli-alt-up
cli-alt-up:
	pipenv run docker-compose up -d cli-alt

.PHONY: cli-alt-stop
cli-alt-stop:
	pipenv run docker-compose stop cli-alt

.PHONY: cli-alt-start
cli-alt-start:
	pipenv run docker-compose start cli-alt

.PHONY: cli-alt-down
cli-alt-down:
	pipenv run docker-compose down cli-alt

.PHONY: cli-alt-build
cli-alt-build:
	pipenv run docker-compose build cli-alt

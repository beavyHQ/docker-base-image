FROM python:latest
MAINTAINER ben@create-build-execute.com

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get upgrade -y

RUN wget https://raw.githubusercontent.com/beavyHQ/beavy/master/.infrastructure/install_icu.sh
RUN sh install_icu.sh

RUN wget https://raw.githubusercontent.com/beavyHQ/beavy/master/beavy/requirements/base.txt
RUN pip install -r base.txt
RUN pip install pyyaml

ENV BEAVY_ENV PRODUCTION
RUN mkdir -p /app

ONBUILD WORKDIR /app
ONBUILD ADD beavy/ /app/beavy/
ONBUILD ADD beavy_modules /app/beavy_modules/
ONBUILD ADD beavy_apps /app/beavy_apps/
ONBUILD ADD migrations /app/migrations/
ONBUILD ADD var/assets/ /app/assets/
ONBUILD ADD config.yml /app/
ONBUILD ADD .infrastructure/docker/Procfile /app
ONBUILD ADD .infrastructure/docker/run.sh /app/run.sh

ONBUILD ADD *.py /app/

ONBUILD RUN python install.py

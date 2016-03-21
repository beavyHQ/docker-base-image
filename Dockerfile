FROM python:latest
MAINTAINER ben@create-build-execute.com

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get upgrade -y

ADD .infrastructure/install_icu.sh /root
RUN /root/install_icu.sh

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

ONBUILD RUN pip install pyyaml
ONBUILD RUN python install.py

FROM alpine:latest

WORKDIR /app

COPY ./config /app/config
COPY ./management-console-app /app/management-console-app
COPY ./web-app /app/web-app
COPY ./docker_password.txt /docker_password.txt
COPY ./docker-compose.yml /app/docker-compose.yml
COPY ./init-config-folder.sh /app/init-config-folder.sh

ENV PYTHONUNBUFFERED=1
# ENV http_proxy="http://proxy.mfdemoportal.com:443"

RUN apk update && apk upgrade
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN apk add --no-cache bash git openssh docker openrc docker-compose vim

# RUN docker login -u advantageonlineshoppingapp -p W3lcome1
RUN cat /docker_password.txt | docker login --username advantageonlineshoppingapp --password-stdin
RUN cd config && git init && \ 
    git config --global user.name "Advbank Microfocus" && \
    git config --global user.email "email@microfocus.com" && \
    git add --all && \
    git commit -m "initial commit"

ENV http_proxy=""

CMD ["ash","./init-config-folder.sh"]
FROM python:3.11.4-alpine3.18

WORKDIR /app

COPY . /app/robot-aws

WORKDIR /app/robot-aws

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install awscli

RUN apk update
RUN apk upgrade
RUN apk add g++




# variaveis Do amazon s3
ARG ACESSKEY
ENV ACESSKEY=$ACESSKEY

ARG SECRETKEY
ENV SECRETKEY=$SECRETKEY

ARG REGION
ENV REGION=$REGION

RUN pip install -r requirements.txt

WORKDIR     /app/robot-aws/robot-amazon

# RUN robot -d ./logs robot-amazon/tests/test.robot

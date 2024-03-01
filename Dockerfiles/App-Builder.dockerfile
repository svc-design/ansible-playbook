# Use an official alpine as a parent image
FROM alpine:latest

# Update and install necessary packages
RUN apk add --no-cache curl bash docker docker-compose

# Install jfrog-cli
RUN curl -fL https://getcli.jfrog.io | sh && mv jfrog /usr/local/bin/

# Install helm
RUN apk add --no-cache openssl coreutils
RUN wget https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz
RUN tar -zxvf helm-v3.6.3-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm

# Define an entrypoint
ENTRYPOINT ["/bin/bash"]
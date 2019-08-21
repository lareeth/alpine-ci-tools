FROM alpine

RUN apk add --update curl bash

# Kubernetes CLI
RUN curl -s -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.3/bin/linux/amd64/kubectl && \
	chmod +x ./kubectl && \
	mv ./kubectl /usr/local/bin/kubectl

# Helm
RUN curl -s -LO https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz && \
	tar -zxvf helm-v2.14.3-linux-amd64.tar.gz && \
	mv linux-amd64/helm /usr/local/bin/helm && \
	rm -rf helm-v2.14.3-linux-amd64.tar.gz

# Azure CLI
RUN apk add --update py-pip && \
	apk add --update --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make && \
	pip --no-cache-dir install azure-cli && \
	apk del --purge build
	
RUN kubectl version --client

RUN helm version --client

RUN az --version
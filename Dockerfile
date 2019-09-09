FROM --platform=$BUILDPLATFORM alpine

ARG KUBERNETES_VERSION=1.14.6
ARG HELM_VERSION=2.14.3
ARG AZURE_VERSION=2.0.72

RUN apk add --update curl bash

# Kubernetes CLI
RUN curl -s -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && \
	chmod +x ./kubectl && \
	mv ./kubectl /usr/local/bin/kubectl

# Helm
RUN curl -s -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
	tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
	mv linux-amd64/helm /usr/local/bin/helm && \
	rm -rf helm-v${HELM_VERSION}-linux-amd64.tar.gz

# Azure CLI
RUN apk add --update py-pip && \
	apk add --update --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make && \
	pip --no-cache-dir install azure-cli==${AZURE_VERSION} && \
	apk del --purge build

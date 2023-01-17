# Coralogix Azure serverless integration deployment container
Deployment framework for Azure Integrations for the Coralogix platform

Coralogix provides a seamless integration with ``Azure`` cloud so you can send your logs from anywhere and parse them according to your needs.

## Prerequisites

* An Azure account with an active subscription

* Docker

## Installation

Clone this repo:

```bash
$ git clone https://github.com/MichaelBriggs-Coralogix/coralogix-azure-deploy.git
$ cd coralogix-azure-deploy
```

Modify the requisite .vars file for your intended integration deployment:

```bash
BlobStorage.vars
StorageQueue.vars
EventHub.vars
```

Build the docker container:

```bash
# Command for x86 (Intel/AMD) processors.
$ docker build -t azure-deploy .

# Command for ARM (M1/M2 Mac) processors:
$ docker buildx build --platform linux/amd64 -t azure-int-dep .
```

Once the image is built, run it and pass in your integration variables file:

```bash
$ docker run -it --rm --platform linux/amd64 --env-file <integration>.vars azure-int-dep
```

The Azure CLI will request authorization. You'll need to follow the prompt and authenticate through your browser with a provided code.
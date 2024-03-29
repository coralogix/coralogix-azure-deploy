

+++++++++++++++++++++++++++++++++

# Deprecated - Please do not use

+++++++++++++++++++++++++++++++++

# Coralogix Azure serverless integration deployment container
Deployment framework for Azure Integrations for the Coralogix platform

Coralogix provides a seamless integration with ``Azure`` cloud so you can send your logs from anywhere and parse them according to your needs.

## Prerequisites

* An Azure account with an active subscription

* Docker

## Installation

Clone this repo:

```bash
$ git clone https://github.com/coralogix/coralogix-azure-deploy.git
$ cd coralogix-azure-deploy
```

Modify the requisite .vars file for your intended integration deployment:

```bash
BlobStorage.vars
BlobViaEventGrid.vars
StorageQueue.vars
EventHub.vars
```

Using a pre-built docker container, run it and pass in your integration variables file:
```bash
$ docker run -it --rm --platform linux/amd64 --env-file <integration>.vars coralogixrepo/azure-functions-deploy
```

The Azure CLI will request authorization. You'll need to follow the prompt and authenticate through your browser with a provided code.

## Manual build

If you're unable to use the pre-built container, you can build it yourself using the steps below (Won't work with Windows)

Build the docker container:

```bash
# Command for x86 (Intel/AMD) processors.
$ docker build -t azure-functions-deploy .

# Command for ARM (M1/M2 Mac) processors:
$ docker buildx build --platform linux/amd64 -t azure-functions-deploy .
```

Once the image is built, run it and pass in your integration variables file:

```bash
$ docker run -it --rm --platform linux/amd64 --env-file <integration>.vars azure-functions-deploy
```


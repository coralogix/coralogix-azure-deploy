FROM node:16-bullseye

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ bullseye main" > /etc/apt/sources.list.d/azure-cli.list
RUN echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/dotnetdev.list
RUN apt-get update && apt-get install -y azure-functions-core-tools-4 azure-cli
RUN mkdir /app

WORKDIR /app
COPY entrypoint.sh .
RUN chmod ug+x entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
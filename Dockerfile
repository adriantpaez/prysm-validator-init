FROM debian:stable-20221004-slim

ARG PRYSM_VERSION=master
# Configure user
USER root
WORKDIR /
# Install dependencies
RUN apt-get update && apt-get install -y curl
# Install prysm
RUN curl https://raw.githubusercontent.com/prysmaticlabs/prysm/${PRYSM_VERSION}/prysm.sh --output prysm.sh && chmod +x prysm.sh

COPY validator-init.sh .
RUN chmod +x validator-init.sh

CMD [ "/bin/sh", "validator-init.sh" ]

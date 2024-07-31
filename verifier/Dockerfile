# FROM benk79tb/keripy
# FROM gleif/keri:1.0.0
FROM benk79tb/keripy:kentbull

# FROM weboftrust/keri:1.1.15
# FROM keri



RUN apk --no-cache add \
    linux-headers \
    jq \
    tcpflow

SHELL ["/bin/bash", "-c"]

# EXPOSE 5632
# EXPOSE 5633

RUN git clone https://github.com/benk79tb/sally.git && cd sally && python3 -m pip install -e ./
# COPY sally sally
# RUN cd sally && python3 -m pip install -e ./


RUN mkdir -p /keri


COPY oobi-bootstrap.json /usr/local/var/keri/cf/ben.json
COPY oobi-bootstrap.json /usr/local/var/keri/cf/ben2.json
COPY oobi-bootstrap.json /owner/keri/cf/oobi-bootstrap.json
COPY inception-config.json /owner/keri/cf/inception-config.json

COPY entrypoint.sh /keri
WORKDIR /keri
RUN mkdir /agent_static

ENV CONFIG_DIR=/owner
ENV CONFIG_FILE=${CONFIG_DIR}/keri/cf/oobi-bootstrap.json
ENV INCEPT_CONFIG_FILE=/owner/keri/cf/inception-config.json
ENV NAME=owner
ENV SALT=0AB3YW5uLXRoZS13aXRuZXNz
ENV VC_REGISTRY=1
ENV PYTHONUNBUFFERED=1

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]
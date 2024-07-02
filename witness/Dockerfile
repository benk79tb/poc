# FROM gleif/keri:1.0.0
# FROM keri
# FROM benk79tb/keripy
FROM benk79tb/keripy:kentbull
# FROM weboftrust/keri:1.1.15


SHELL ["/bin/bash", "-c"]

# EXPOSE 5632
# EXPOSE 5633

RUN mkdir -p /keri


COPY wan-witness.json /witness/keri/cf/main/wan-witness.json

COPY witness_entrypoint.sh /keri
WORKDIR /keri


ENV CONFIG_DIR=/witness
ENV CONFIG_FILE=wan-witness
ENV NAME=wan
ENV SALT=0AB3YW5uLXRoZS13aXRuZXNz

ENTRYPOINT [ "/bin/bash", "witness_entrypoint.sh" ]
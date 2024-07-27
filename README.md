Witnesses

docker build -f witness.demo.dockerfile -t witness .

docker run -it witness

docker run -it \
    -v ./witness_2:/witness/keri/cf/main
    -e CONFIG_DIR='/witness' \
    -e CONFIG_FILE='main/wes-witness' \
    -e NAME='wes' \
    -e SALT='0AB3YW5uLXRoZS13aXRuZXNz' \
    witness


docker run -it -p 5631:5631 -v ./witness_2:/witness/keri/cf/main -e CONFIG_DIR='/witness' -e CONFIG_FILE='main/wes-witness' -e NAME='wes' -e SALT='0AB3YW5uLXRoZS13aXRuZXNz' witness





docker build -f keripy-base.dockerfile -t benk79tb/keripy:poc-1.0.1 .
docker build -t lmdb_analyzer .

cleanup.sh
docker compose up

docker run -v "$(PWD)/data:/data" -it benk79tb/lmdb_analyzer:1.0.1 bash

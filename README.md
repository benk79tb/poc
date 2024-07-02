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
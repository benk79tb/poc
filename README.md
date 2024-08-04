# Swiss eID system with KERI-py

This is a proof of concept for a swiss electronic id system using  KERI-py.

It uses docker compose to simulate and isolate various services and actors
in an interconnected system.

You can run it by executing a bash script:

```bash
./experience.sh
```

The `data` directory will contain all relevant data to be analyzed,
with a file named `experience.log` on top.

The experience is splitted into steps with `sleep` command between them
in order to facilitate the analysys of tcpflow log files by comparing 
to the steps in `experience.log`.

Data are cleaned up at beginning of each run, and can be cleaned at any moment
by executing:

```bash
./cleanup.sh
```

# WARNINNG
Everything below this line is still here as reminder but shall be removed.

______________________________________________________________________


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

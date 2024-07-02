# Swiss governement server


##  Base configuration

Create / edit the schema for verified credentials under the `schemas` folder.

These schemas must follow the ACDC specification.

Edit the `schema_map.json` to reflect the hierarchy of credentials

## Saidified Schemas

As next step we need to create SAID for every schema.
We can do this with kaslcred from chgov directory

```
docker run -v .:/data -it kaslcred
python -m kaslcred /data/schemas /data/results /data/schemas/schema_map.json
```

## Serve with vLEI server

docker run -v .:/data -p 7723:7723 -it vlei
vLEI-server -s /data/results -c /data/cache/acdc -o /data/cache/oobis
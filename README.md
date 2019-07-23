# redash  oracle 7.0.0.b18042

> fork from https://github.com/joaoleite/redash_oracle and change oracle client version

## how  to running

* change env

> for email && db password

```code
opt/redash/env
``

* running

```code
docker-compose up -d
```

* generage db tables

```code
docker-compose run --rm server create_db
```

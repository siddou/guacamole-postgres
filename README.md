# init db:
```shell
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > sql-scripts/initdb.sql
docker volume create --name=postgres_database
```
# run:
```shell
docker-compose up -d
```






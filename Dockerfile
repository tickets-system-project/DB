FROM postgres:14-alpine3.20

COPY scheme.sql /docker-entrypoint-initdb.d/01_scheme.sql
COPY dane.sql /docker-entrypoint-initdb.d/02_dane.sql

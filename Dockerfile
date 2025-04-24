FROM postgres:14-alpine3.20

COPY scheme.sql /docker-entrypoint-initdb.d/01_scheme.sql
COPY dane1.sql /docker-entrypoint-initdb.d/02_dane1.sql

COPY mockGen.sh ./

RUN bash mockGen.sh

RUN mv ./dane2.sql /docker-entrypoint-initdb.d/03_dane2.sql

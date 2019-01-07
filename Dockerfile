FROM postgres:11.1
MAINTAINER Artem Kubrachenko

ENV POSTGRES_USER=root
ENV POSTGRES_PASSWORD=root
ENV POSTGRES_DB=srmsystem

COPY dbdump2 /tmp
RUN touch /docker-entrypoint-initdb.d/restoredb.sh
RUN echo "psql srmsystem < /tmp/dbdump2 -U root" >> /docker-entrypoint-initdb.d/restoredb.sh
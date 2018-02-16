FROM ubuntu:16.04

COPY ACCC4CF8.asc /tmp/ACCC4CF8.asc
RUN apt-key add /tmp/ACCC4CF8.asc \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt update \
    && apt install postgresql-9.5 graphviz openjdk-8-jdk -y

RUN mkdir /media/data \
    && chmod 777 /media/data \
    && chown postgres:postgres /media/data \
    && mkdir /media/log \
    && chmod 777 /media/log \
    && touch /media/log/postgres.log \
    && chmod 777 /media/log/postgres.log

COPY runtime.sh /tmp/runtime.sh
RUN chmod 777 /tmp/runtime.sh

WORKDIR /media/MTS
CMD ["/tmp/runtime.sh"]

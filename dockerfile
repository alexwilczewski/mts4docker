FROM ubuntu:16.04

COPY ACCC4CF8.asc /tmp/ACCC4CF8.asc
RUN apt-key add /tmp/ACCC4CF8.asc
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt update
RUN apt install postgresql-9.5 -y
RUN apt install graphviz -y
RUN apt install openjdk-8-jdk -y

RUN mkdir /media/data
RUN chmod 777 /media/data
RUN chown postgres:postgres /media/data
RUN mkdir /media/log
RUN chmod 777 /media/log
RUN touch /media/log/postgres.log
RUN chmod 777 /media/log/postgres.log

WORKDIR /media/MTS
CMD ["/tmp/runtime.sh"]

COPY runtime.sh /tmp/runtime.sh
RUN chmod 777 /tmp/runtime.sh

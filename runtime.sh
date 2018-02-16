#!/bin/bash

datadir="/media/MTS/data"
logpath="/media/MTS/postgres.log"
dbbackuppath="/media/MTS/$dbbackupfile"
appjarpath="/media/MTS/$appjarfile"
pgjarpath="/media/MTS/$postgresjarfile"
inpath="/media/MTS/$testfile"

if [ -d $datadir ]; then
# Run JAVA
  exec java -cp "$appjarpath:$pgjarpath" edu.gatech.Main < $inpath
else
# Initialize DB
  mkdir $datadir
  chown postgres:postgres $datadir
  chmod 777 $datadir
  su postgres -c "PATH=\$PATH:/usr/lib/postgresql/9.5/bin && initdb -D $datadir"
# Startup DB
  touch $logpath
  chown postgres:postgres $logpath
  chmod 777 $logpath
  su postgres -c "PATH=\$PATH:/usr/lib/postgresql/9.5/bin && pg_ctl -D $datadir -l $logpath start"
# Wait for fully loaded server
  sleep 1
# Insert data
  su postgres -c "psql -f $dbbackuppath postgres"
fi

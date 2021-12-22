#!/bin/bash

# Variaveis
USER=ec2-user
HOST=ec2.com.br
PORT=22
BKPHOME=/home/ec2-user/dump_postgresql_container/backups
BKPNAME=backup_db_app_$(date -d "-1days" +"%d-%m-%Y").tar.bz2

echo "Pegando backup do banco compactado"
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
-P $PORT $USER@$HOST:$BKPHOME/$BKPNAME . 2>/dev/null & PID=$!

echo "Fazendo o download do backup compactado, aguarde..."
printf "["
# While do processo rodando
while kill -0 $PID 2> /dev/null; do 
    printf  "="
    sleep 1
done
printf "] Finalizado!\n"

echo "Extraindo bkp para o entrypoint"
tar -xjf $BKPNAME -C /docker-entrypoint-initdb.d/ && \
rm -f $BKPNAME

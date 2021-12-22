FROM postgres:10-alpine

RUN apk add --update --no-cache sshpass tar openssh-client coreutils tzdata \
&& rm -fr /var/cache/apk/* \
&& mkdir ~/.ssh

ENV TZ America/Sao_Paulo

COPY dump_catch.sh .

COPY keyssh/ /root/.ssh

RUN chmod 600 /root/.ssh/id_rsa \
&& chmod +x dump_catch.sh \
&& ./dump_catch.sh

EXPOSE 5432

ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "postgres" ]

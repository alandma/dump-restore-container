# Pegar backup e restaurar no container db

Esse script pega o backup gerado [dump-container](https://bitbucket.org/alandma/dump-container-postgresql/src/master/) e restaura no container de banco de dados.

## Configuração

Gere uma chave _privada_ e _publica_ e adicione na pasta `keyssh` e depois, passe a chave publica para o servidor que deseja acessar. 

No `Dockerfile` adicione a configuração para adicionar as chaves e o script para pegar o backup e restaurar.
> O `Dockerfile` de exemplo utiliza o alpine como base.

```Dockerfile
RUN apk add --update --no-cache sshpass tar openssh-client coreutils tzdata \
&& rm -fr /var/cache/apk/* \
&& mkdir ~/.ssh

ENV TZ America/Sao_Paulo

COPY dump_catch.sh .

COPY keyssh/ /root/.ssh

RUN chmod 600 /root/.ssh/id_rsa \
&& chmod +x dump_catch.sh \
&& ./dump_catch.sh
```

## Gerando chave RSA
```bash
ssh-keygen -b 4096 -C db-container
```

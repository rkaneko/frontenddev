My front end dev env
===

### Prerequisites

```bash
$ docker -v
Docker version 17.06.0-ce

$ docker-compose -v
docker-compose version 1.14.0
```

### Usage

```bash
$ git clone https://github.com/rkaneko/frontenddev.git
$ cd frontenddev

$ chmod +x npm.sh
```

### `npm.sh` ?

`npm.sh` is a wrapper script that npm command in docker container.

So, you can use `npm.sh` like following.

```bash
# = npm init -f
$ ./npm.sh init -f

# = npm test
$ ./npm.sh test

# = npm run blahblah
$ ./npm.sh run blahblah
```

### HTTP server with back-end API server

```bash
$ docker-compose -f docker/docker-compose.yml up nginx
# access localhost:8888 & localhost:8888/graphql
```

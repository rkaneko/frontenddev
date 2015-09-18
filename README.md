My front end dev env
===

### Usage

```bash
$ git clone https://github.com/rkaneko/frontenddev.git
$ cd frontenddev

# Pls edit USERNAME and PASSWORD in Dockerfile

$ docker build -t rkaneko/frontenddev .
$ docker run -d -p 2222:22 -p 8888:80 rkaneko/frontenddev

# see nginx
$ curl http://localhost:8888/

# ssh login
$ ssh ${YOUR_NAME}@127.0.0.1 -p 2222
```

#### Credit

+ [Dockerで複数プロセスを起動する at Less is Best](http://yss44.hatenablog.com/entry/2014/01/05/031736)

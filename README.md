# Golang pprof proxy

Exposing pprof [via HTTP](https://golang.org/pkg/net/http/pprof/) is useful to observe running Go processes. When having multiple processes behind a load balancer, you need a way to query pprof endpoints of specific instances. The goal of this pprof proxy is just that: proxy pprof requests to a specific target. The proxy also provides a simple security mechanism via basic authentication.

---

## Setup

Deploy a container in the same subnet as the instances of interest using your favorite Docker container orchestrator.

You can specify `PPROF_USER` and `PPROF_PASSWORD` for HTTP basic authentication.

Using Docker command-line:

```bash
$ docker run -d -p 8080:80 johanstokking/go-pprof-proxy
```

Using [Docker Compose](https://docs.docker.com/compose/compose-file/):

```yaml
version: '3'
services:
  proxy:
    image: johanstokking/go-pprof-proxy
    ports:
      - '8080:80'
    environment:
      - PPROF_USER=admin
      - PPROF_PASSWORD=admin
  target:
    image: my-app  # your image exposing pprof
```

## Usage

You can query a target host by using the `host` query parameter. For example:

```bash
$ curl --user admin:admin http://localhost:8080/debug/pprof/heap\?host\=target:1234
```

Where `target:1234` is the private address of the container of interest exposing pprof.

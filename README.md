# Apache Stanbol in Docker
---

Apache Stanbol (FULL) 1.0.0 Docker image.

### How to use this image:

Pull the pre-built image from Dockerhub

```sh
docker pull manuellr/apache-stanbol
```

then start a new container:

```sh
docker run -id -p 8080:8080 --name stanbol -t manuellr/apache-stanbol
```

**Available environment variables:**

 - JAVA_OPTS - Settings for the JAVA run time environment. Default: `-Xmx1g -XX:MaxPermSize=256m` . Which is the recommended settings from the [Stanbol tutorial](https://stanbol.apache.org/docs/trunk/tutorial.html).

### Licence
[MIT](https://tldrlegal.com/license/mit-license)

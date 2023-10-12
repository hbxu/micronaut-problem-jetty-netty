## Micronaut 4.1.4 Problem description server set to Jetty but gets Netty

Custom `Dockerfile` for jar to native image.
Maven package, the jar contains netty dependency while jetty should be used.

```powershell
63.82 Error: Classes that should be initialized at run time got initialized during image building:
63.82  org.slf4j.LoggerFactory was unintentionally initialized at build time. io.netty.channel.AbstractChannel caused initialization of this class with the following trace:
63.82   at org.slf4j.LoggerFactory.<clinit>(LoggerFactory.java:98)
...
63.82 org.slf4j.simple.SimpleLogger was unintentionally initialized at build time. io.netty.channel.AbstractChannel caused initialization of this class with the following trace:      
63.82   at org.slf4j.simple.SimpleLogger.<clinit>(SimpleLogger.java:154)
...
```

adding args for Netty, native-image would still fail with same above errors
```powershell
        --initialize-at-build-time=io.netty.channel.AbstractChannel \
```


## Steps to reproduce

- [Micronaut Launch](https://micronaut.io/launch/)
- features: [app-name, graalvm, http-client-test, java, java-application, jetty-server, junit, maven, maven-enforcer-plugin, micronaut-aot, micronaut-http-validation, properties, readme, serialization-jackson, shade, slf4j-simple]
- unzip
- cd to project
- mvn clean package
- docker build . -t test-jetty-netty
- target/docker-graalvm-0.1.jar contains netty dependencies instead of jetty

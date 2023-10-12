FROM ghcr.io/graalvm/native-image-community:17-ol9 AS graalvm
COPY target /home/app/target
WORKDIR /home/app
RUN native-image -jar target/docker-graalvm-0.1.jar application

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/application .
ENTRYPOINT ["./application"]
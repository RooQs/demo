# 构建阶段：使用GraalVM官方镜像
FROM ghcr.io/graalvm/native-image-community:21-ol9  AS builder
WORKDIR /app
COPY target/demo.jar demo.jar
RUN native-image -jar demo.jar  --static -H:Name=demo -O1 --no-fallback

# 运行阶段：使用Alpine精简镜像
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/demo /app/demo
RUN chmod +x /app/demo
ENTRYPOINT ["/app/demo"]
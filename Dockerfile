# 构建阶段：使用GraalVM官方镜像
FROM ghcr.io/graalvm/native-image-community:21-ol9  AS builder
WORKDIR /app
COPY target/*.jar app.jar
RUN native-image -jar app.jar  --static -H:Name=app -O1 --no-fallback

# 运行阶段：使用Alpine精简镜像
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/app /app/executable
RUN chmod +x /app/executable
ENTRYPOINT ["/app/executable"]
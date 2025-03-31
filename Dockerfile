FROM alpine:3.19
WORKDIR /app
COPY --from=builder target/demo /app/executable
RUN chmod +x /app/executable
ENTRYPOINT ["/app/executable"]
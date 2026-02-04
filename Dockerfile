FROM golang:alpine AS builder
RUN go install github.com/OJ/gobuster/v3@latest

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/bin/gobuster /usr/local/bin/
WORKDIR /app
ENTRYPOINT ["gobuster"]

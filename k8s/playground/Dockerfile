FROM golang:1.24-alpine as builder
WORKDIR /practice-dk
COPY practice-dk/ .
RUN go mod tidy
RUN go build -o main

FROM alpine:latest
COPY --from=builder /practice-dk/main .
EXPOSE 3030
ENTRYPOINT  ["./main"]

FROM golang:1.16.5-alpine as builder

WORKDIR /src

COPY go.mod .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o nginx-errors .

FROM debian:stretch

WORKDIR /

COPY --from=builder /src/nginx-errors .

COPY www www

ENTRYPOINT ["/nginx-errors"]

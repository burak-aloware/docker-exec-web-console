FROM golang:1.16-alpine

RUN apk --update add socat

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY main.go ./

RUN go build -o /main

ADD index.html /
ADD xterm /xterm

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8888

CMD ["/main"]


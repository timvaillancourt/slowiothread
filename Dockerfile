FROM golang:1.24-bookworm AS build

# build row-inserter binary
RUN mkdir -p /go/src/github.com/timvaillancourt/slowiothread
COPY . /go/src/github.com/timvaillancourt/slowiothread
WORKDIR /go/src/github.com/timvaillancourt/slowiothread

RUN go build -o row-inserter main.go


# runtime container
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl

COPY --from=build /go/src/github.com/timvaillancourt/slowiothread/row-inserter /usr/local/bin/row-inserter

ADD entrypoint.sh /entrypoint.sh

USER nobody
ENTRYPOINT ["/entrypoint.sh"]

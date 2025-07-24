FROM golang:1.24-bookworm AS build

# ghostblaster
RUN mkdir -p /go/src/github.com/timvaillancourt/slowiothread
COPY . /go/src/github.com/timvaillancourt/slowiothread
WORKDIR /go/src/github.com/timvaillancourt/slowiothread

RUN go build -o inserter main.go


# runtime container
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl

COPY --from=build /go/src/github.com/timvaillancourt/slowiothread/inserter /usr/local/bin/inserter

ADD entrypoint.sh /entrypoint.sh

USER nobody
ENTRYPOINT ["/entrypoint.sh"]

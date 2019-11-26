FROM golang:1.13-alpine

RUN mkdir -p /go
ENV GOPATH=/go

RUN if [[ -z "$(which ko)" ]]; then GO111MODULE=on go get github.com/google/ko/cmd/ko ; fi

ENTRYPOINT ['/go/bin/ko', 'version']

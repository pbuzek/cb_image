FROM golang:1.13-alpine
  

ENV GOPATH=
RUN if [[ -z "$(which ko)" ]]; then GO111MODULE=on go get github.com/google/ko/cmd/ko ; fi


CMD go version &&  $HOME/go/bin/ko version
FROM golang:1.13-alpine

RUN apk add --update --no-cache git curl bash dpkg

RUN mkdir -p /go
ENV GOPATH=/go

RUN if [[ -z "$(which ko)" ]]; then GO111MODULE=on go get github.com/google/ko/cmd/ko ; fi
RUN if [[ -z "$(which kail)" ]]; then GO111MODULE=on go get github.com/boz/kail/cmd/kail ; fi
RUN if [[ -z "$(which dep)" ]]; then go get -u github.com/golang/dep/cmd/dep ; fi
RUN if [[ -z "$(which go-junit-report)" ]]; then go get -u github.com/jstemmer/go-junit-report ; fi
RUN if [[ -z "$(which liche)" ]]; then GO111MODULE=on go get -u github.com/raviqqe/liche ; fi

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin

RUN if [[ -z "$(which goveralls)" ]]; then go get github.com/mattn/goveralls ; fi

# RUN wget https://github.com/bazelbuild/bazel/releases/download/1.2.0/bazel_1.2.0-linux-x86_64.deb
# RUN dpkg -i bazel_1.2.0-linux-x86_64.deb

# single vs double quote matters
ENTRYPOINT ["cb_setup.sh"]

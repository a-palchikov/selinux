FROM golang:1.16.2-buster

RUN set -ex && \
	go install github.com/gravitational/tpl@latest

FROM registry.centos.org/centos/centos:7

RUN set -ex && yum -y install \
	selinux-policy-targeted \
	selinux-policy-devel \
	bzip2 \
	make

COPY --from=0 /go/bin/tpl /usr/local/bin/

RUN mkdir -p /src

ADD .bashrc /root/.bashrc

WORKDIR "/src"
VOLUME ["/src"]

{{define "oraclejdk"}}
# Use Oracle's Offical JDK
{{end}}

{{define "apk"}}
# Install JDK 8 from APK
RUN apk add --no-cache openjdk8
{{end}}

{{define "yum"}}
# Install JDK 8 from YUM
RUN yum install -y java-1.8.0-openjdk-headless
{{end}}

{{define "apt"}}
# Install JDK 8 from APT
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DA1A4A13543B466853BAF164EB9B1D8886F44E2A
RUN echo "deb http://ppa.launchpad.net/openjdk-r/ppa/{{.Env.OS_FAMILY}} {{.Env.OS_FLAVOR}} main" >/etc/apt/sources.list.d/openjdk.list && \
  echo "deb-src http://ppa.launchpad.net/openjdk-r/ppa/{{.Env.OS_FAMILY}} {{.Env.OS_FLAVOR}} main" >>/etc/apt/sources.list.d/openjdk.list
RUN apt-get update
RUN apt-get install -qy openjdk-8-jdk-headless
{{end}}

{{/* Decide which way to install Java */}}
{{if defined .Env.USE_ORACLE_JDK}}
  {{template "oraclejdk" .}}
{{else if or (eq (index .Env "OS_FAMILY") "ubuntu") (eq (index .Env "OS_FAMILY") "debian")}}
  {{template "apt" .}}
{{else if eq (index .Env "OS_FAMILY") "alpine"}}
  {{template "apk" .}}
{{else if eq (index .Env "OS_FAMILY") "centos"}}
  {{template "yum" .}}
{{end}}

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
{{if eq (index .Env "OS_FAMILY") "debian"}}
RUN echo "deb http://http.debian.net/debian {{index .Env "OS_FLAVOR"}}-backports main" >/etc/apt/sources.list.d/openjdk.list && \
  echo "deb-src http://http.debian.net/debian {{index .Env "OS_FLAVOR"}}-backports main" >>/etc/apt/sources.list.d/openjdk.list
{{else if eq (index .Env "OS_FAMILY") "ubuntu"}}
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DA1A4A13543B466853BAF164EB9B1D8886F44E2A
RUN echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu {{index .Env "OS_FLAVOR"}} main" >/etc/apt/sources.list.d/openjdk.list && \
  echo "deb-src http://ppa.launchpad.net/openjdk-r/ppa/ubuntu {{index .Env "OS_FLAVOR"}} main" >>/etc/apt/sources.list.d/openjdk.list
{{end}}
RUN apt-get update
RUN apt-get install -qy openjdk-8-jdk-headless
{{end}}

{{/* Decide which way to install Java */}}
{{$os_fam := index .Env "OS_FAMILY"}}
{{if eq $os_fam "alpine"}}
  {{template "apk" .}}
{{else if eq $os_fam "centos"}}
  {{template "yum" .}}
{{else if eq $os_fam "debian" "ubuntu"}}
  {{template "apt" .}}
{{end}}

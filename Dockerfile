FROM ubuntu:12.04
RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential curl git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy mercurial
RUN curl -s https://go.googlecode.com/files/go1.2.1.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
ADD . /opt/ngrok
RUN cd /opt/ngrok && make client
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy curl
EXPOSE 4040
ENTRYPOINT ["/opt/ngrok/bin/ngrok", "-config=/opt/ngrok/config.yml"]

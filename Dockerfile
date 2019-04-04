FROM alpine
RUN apk add docker
RUN apk add socat
COPY . /gkpown
WORKDIR /gkpown
Run chmod +x socat-shell.sh
ENTRYPOINT [ "./socat-shell.sh" ]


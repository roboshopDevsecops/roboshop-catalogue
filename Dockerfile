FROM docker.io/library/golang:1.22 AS builder
WORKDIR /app
COPY go.mod ./
COPY . .
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux go build -o catalogue .

FROM docker.io/redhat/ubi9:latest
RUN dnf install -y ca-certificates && dnf clean all
WORKDIR /app
COPY --from=builder /app/catalogue .
COPY run.sh /run.sh
RUN chmod +x /run.sh catalogue
EXPOSE 8080
ENTRYPOINT ["bash", "/run.sh"]

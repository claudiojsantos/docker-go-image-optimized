FROM golang:latest as builder

LABEL maintainer "claudio@sistnet.com.br"

RUN mkdir -p /app
WORKDIR /app

COPY go.mod .

ENV GOPROXY https://proxy.golang.org,direct

RUN go mod download

COPY . . 

ENV CGO_ENABLED=0

RUN go build ./fullcycle.go


FROM scratch
WORKDIR /app
COPY --from=builder /app/fullcycle .

CMD ["/app/fullcycle"]

FROM golang:1.16.6-alpine3.14 as builder
RUN mkdir /app
COPY ./ /app/
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .

#scratch
FROM scratch
WORKDIR /root/
COPY --from=builder /app/server .
CMD ["./server"]
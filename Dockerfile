FROM golang:1.17-alpine as builder

WORKDIR /go/src
COPY . .

# RUN go build main.go
#ENV GOOS=linux GOARCH=amd64 CGO_Enabled=0
RUN CGO_Enabled=0 go build main.go

FROM scratch

COPY --from=builder /go/src/main main
#RUN ls
#RUN pwd
# Use and unprivileged user.
USER 1001:1001

#Expose Service Port
EXPOSE 8080

CMD ["./main"]


# lookup howto:
# create kuberneties manifest for our pod
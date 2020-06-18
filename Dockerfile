FROM golang:1.13.5 as builder

WORKDIR /hello-app

COPY . ./
RUN make buildgo


FROM scratch

WORKDIR /

COPY --from=builder /hello-app/hello-app ./hello-app
COPY index.html ./

EXPOSE 8080
ENTRYPOINT ["/hello-app"]
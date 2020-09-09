FROM golang:alpine as builder

RUN apk update && apk add git

WORKDIR /app
RUN git clone https://github.com/porjo/youtubeuploader.git
WORKDIR /app/youtubeuploader
RUN GOOS=linux GOARCH=amd64 go build -o youtubeuploader
RUN chmod +x youtubeuploader

FROM golang:alpine
COPY --from=builder /app/youtubeuploader/youtubeuploader /usr/local/bin/youtubeuploader
RUN echo $PATH

CMD [ "youtubeuploader", "--help" ]

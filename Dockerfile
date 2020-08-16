FROM ruby:2.7

WORKDIR /exercise

COPY . .

RUN bundle install

ENTRYPOINT ["/bin/bash", "-c"]

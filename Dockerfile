FROM ruby:3.4.1-slim

RUN mkdir /PuroRuby

WORKDIR /PuroRuby

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN bundle install

EXPOSE 5000

CMD [ "ruby", "main.rb" ]
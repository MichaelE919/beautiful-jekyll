FROM mangar/jekyll:1.0

MAINTAINER Marcio Mangar "marcio.mangar@gmail.com"

RUN gem install jekyll
RUN gem install bundler

RUN gem install execjs
RUN gem install therubyracer
RUN gem install json

RUN gem install minitest
RUN gem install colorator
RUN gem install ffi
RUN gem install pkg-config
RUN gem install ethon
RUN gem install nokogiri
RUN gem install html-pipeline
RUN gem install jekyll-watch

RUN mkdir -p /app
ADD ./ /app

WORKDIR /app

EXPOSE 4000

CMD bundle exec jekyll serve

FROM ruby:latest
LABEL maintainer="Michael Eichenberger"

RUN mkdir -p /home/jekyll \
groupadd -rg 1000 jekyll \
useradd -rg jekyll -u 1000 -d /home/jekyll jekyll \
chown jekyll:jekyll /home/jekyll \
gem install jekyll

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

VOLUME /home/jekyll

WORKDIR /home/Jekyll
COPY Gemfile /home/jekyll
COPY Gemfile.lock /home/jekyll
RUN bundle install

EXPOSE 4000

ENTRYPOINT ["jekyll", "serve"]

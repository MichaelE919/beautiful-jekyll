FROM ruby:latest
LABEL maintainer="Michael Eichenberger"

RUN mkdir -p /home/jekyll
RUN groupadd -rg 1000 jekyll
RUN useradd -rg jekyll -u 1000 -d /home/jekyll jekyll
RUN chown jekyll:jekyll /home/jekyll
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

ADD ./ /home/Jekyll

WORKDIR /home/Jekyll

EXPOSE 4000

ENTRYPOINT ["bash", "-c"]
CMD ["bundle install \
&& bundle exec jekyll serve --host 0.0.0.0"]

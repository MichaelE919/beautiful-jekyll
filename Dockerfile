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
RUN gem install pkg-config
RUN gem install ethon
RUN gem install nokogiri
RUN gem install html-pipeline

ADD ./ /home/Jekyll

WORKDIR /home/Jekyll

EXPOSE 4000

ENTRYPOINT ["bash", "-c"]
CMD ["bundle install \
&& bundle exec jekyll serve --host 0.0.0.0 \
--force_polling --watch"]

# to build:
# docker build -t michaele919/jekyll:2.0 .

# suggested run command:
# docker run --name jekyll -p 4000:4000 -v `pwd`:/home/Jekyll michaele919/jekyll:2.0

FROM ruby:2.7.3

RUN mkdir /src

WORKDIR /src/
# COPY src/Gemfile src/Gemfile.lock /src/
# RUN bundle install

ADD src /src

ENTRYPOINT ["/src/entrypoint.rb"]

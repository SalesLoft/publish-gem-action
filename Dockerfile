FROM ruby:2.7.2

RUN mkdir /src

WORKDIR /src/
COPY src/Gemfile src/Gemfile.lock /src/
RUN bundle install

ADD src /src

CMD ["/src/entrypoint.rb"]

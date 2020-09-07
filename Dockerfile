FROM ruby:2.7.1

ENV APP_PATH=/app
ENV BUNDLE_PATH=$APP_PATH/vendor/bundle

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config path $BUNDLE_PATH

RUN bundle install

COPY . ./app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ENV RUBYOPT '-Eutf-8:utf-8'

CMD ["rails", "server", "-b", "0.0.0.0"]
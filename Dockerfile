FROM ruby
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app/

RUN gem install bundler \
    && apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
RUN bundle install

EXPOSE 9292
CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0"]
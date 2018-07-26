FROM ruby
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app/

RUN gem install bundler \
    && apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && bundle install


COPY . /app
EXPOSE 9292
ENTRYPOINT ["bash"]
CMD ["-c", "bundle", "exec", "rackup", "-o", "0.0.0.0"]
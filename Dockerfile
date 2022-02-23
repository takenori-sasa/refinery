FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y sqlite3 libsqlite3-dev imagemagick nodejs graphviz

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN bundle config build.nokogiri --use-system-libraries

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.1

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . .
CMD [ "rackup", "-o0" ]
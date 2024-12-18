# Dockerfile for Ruby on Rails, Ruby v3.3.6, Rails v8.5.0, Node v16.13.0, Yarn v1.22.17, PostgreSQL v14.1, and Redis v7.0.0

# Base image
FROM ruby:3.3.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client redis-server

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y yarn

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# set bundler version
RUN gem install bundler:2.6.0

# Install the gems
RUN bundle install

# Copy the main application into the image
COPY . ./

# Expose the port
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]


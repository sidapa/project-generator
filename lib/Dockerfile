FROM ruby:<ruby_version>

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs yarn mariadb-client

RUN mkdir /<project_name>
WORKDIR /<project_name>
COPY Gemfile /<project_name>/Gemfile
COPY Gemfile.lock /<project_name>/Gemfile.lock
RUN bundle install

ARG FONTAWESOME_NPM_AUTH_TOKEN
ENV FONTAWESOME_NPM_AUTH_TOKEN=$FONTAWESOME_NPM_AUTH_TOKEN

COPY .npmrc /<project_name>/.npmrc
COPY package.json /<project_name>/package.json
COPY yarn.lock /<project_name>/yarn.lock
RUN yarn install

VOLUME /<project_name>

COPY . /<project_name>

RUN bundle exec rake assets:precompile

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
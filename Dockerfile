ARG RUBY_VER

FROM ruby:${RUBY_VER}

ARG APP_DIR

COPY unicorn $APP_DIR
COPY conf.rb $APP_DIR/conf.rb

WORKDIR $APP_DIR

RUN mkdir -p ${APP_DIR}/web_api/log
RUN gem install bundler && bundle install

EXPOSE $UNICORN_PORT

CMD ["/usr/local/bundle/bin/unicorn", "-c", "${APP_DIR}/unicorn.conf"]

# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.3.5

# 作業ディレクトリを設定
WORKDIR /memoapp

# yarn と nodejs のインストール
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends curl gnupg2 \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn@1.22.22

# sqlite3 のインストール
RUN apt-get update -qq && apt-get install -y sqlite3 libsqlite3-dev

# rails のインストール
RUN gem install rails -v 7.2.1

# アプリケーションのソースコードをコピー
COPY . .

RUN bundle install

# RUN rails db:create
# RUN rails webpacker:install
# RUN rails webpacker:install:vue

# ポートを公開
EXPOSE 3000

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"] # docker-compose.ymlでcommandを指定する場合、ここは不要

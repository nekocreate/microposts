source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development
# 本番ではpostgressを使用する
gem 'pg', group: :production

# この gem はアプリが Heroku 上で動作できるように、Rails の動作を変更します。例えば、ログは保存先が変更され、
# 静的アセット(アプリの画像、スタイルシート、JavaScript ファイル) は Heroku 向けに微調整が加えられています。
gem 'rails_12factor', group: :production

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# 今回　turbolinksをコメントアウトした
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# 今回追加した
gem 'bootstrap-sass'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'


# kaminari ページネーション表示用 2015年9月20日追加
gem 'kaminari'

# carrierwave 画像アップローダ
gem 'carrierwave'

# carrierwave でリサイズなどをするために必要
# gem 'rmagick'
# gem 'rmagick', '2.15.4'

# 上記のrmagickではなくmini_magickを使う事とした
gem 'mini_magick'

# carrierwaveでアップロードした画像をcloudinaryに保存するためのgem
gem 'cloudinary'

# lightbox2
gem 'lightbox2-rails'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


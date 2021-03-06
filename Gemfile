source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Better css sytanx
gem 'sass',  '~> 3.2.0'
#gem 'sass',  '~> 3.3.0'

gem 'bootstrap-sass'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# For haml syntax
gem 'haml'

# For creating haml files when performing scaffold
gem 'haml-rails'

# Forms made easy
gem 'simple_form'

# Search
gem 'sunspot_rails'

gem 'sunspot_solr'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# For file upload
gem 'carrierwave'

# For remote file upload
gem 'fog'

# For image manipulation (crop, resize)
gem "mini_magick"

# For pagination
gem 'will_paginate'

# For authorization
gem 'cancan'

gem 'devise'

gem 'prawn'
#PDF Generator

#html to PDF
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

#Timbre Electronico
# gem 'pdf417'
# gem 'chunky_png'

# for charts
gem "chartkick"
gem 'groupdate'

#for autoincrement field
gem "auto_increment"

#for scraping
gem "nokogiri"
gem 'rest-client'

#for barcode images
gem 'barby'

#for data base diagram
gem "rails-erd"

# for icons
gem "font-awesome-rails"

#for page editor
gem "wysiwyg-rails"

  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.0'
  #gem 'sass-rails', '~> 5.0.0'
 

  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Remote multi-server automation tool http://www.capistranorb.com
  gem 'capistrano', '~> 2.15.5'

  # Multiple stages deploy for capistrano
  gem 'capistrano-ext'

  # Pure Ruby implementation of an SSH (protocol 2) client 
  # http://net-ssh.github.com/net-ssh
  gem 'net-ssh', '~> 2.7.0'
end


group :production, :staging do
  # For PostreSQL
  gem 'pg'

  # Use unicorn as the app server
  gem 'unicorn'

  gem 'rb-readline'
end

group :development, :staging do
  # For making rails console work
  gem 'rb-readline'
  # Console in error page
  gem 'binding_of_caller'

end

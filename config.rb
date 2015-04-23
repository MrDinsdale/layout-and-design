set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end


Dotenv.load

activate :s3_sync do |s3|
  s3.bucket                 = ENV['AWS_S3_BUCKET']
  s3.region                 = 'eu-west-1'
  s3.aws_access_key_id      = ENV['AWS_ACCESS_KEY_ID']
  s3.aws_secret_access_key  = ENV['AWS_SECRET_ACCESS_KEY']
  s3.add_caching_policy     'text/css',                 max_age: 31536000, public: true
  s3.add_caching_policy     'text/javascript',          max_age: 31536000, public: true
  s3.add_caching_policy     'application/javascript',   max_age: 31536000, public: true
  s3.add_caching_policy     'image/jpeg',               max_age: 31536000, public: true
  s3.add_caching_policy     'image/png',                max_age: 31536000, public: true
  s3.add_caching_policy     'image/x-icon',             max_age: 31536000, public: true
  s3.add_caching_policy     'image/vnd.microsoft.icon', max_age: 31536000, public: true
  s3.after_build            = true
end

activate :cloudfront do |config|
  config.access_key_id      = ENV['AWS_ACCESS_KEY_ID']
  config.secret_access_key  = ENV['AWS_SECRET_ACCESS_KEY']
  config.distribution_id    = ENV['AWS_DISTRIBUTION_ID']
  config.after_build        = true
end

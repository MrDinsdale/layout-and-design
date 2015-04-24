set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

Dotenv.load

activate :sync do |sync|
  sync.fog_provider = 'AWS'
  sync.fog_directory = '...'
  sync.fog_region = ENV['AWS_REGION']
  sync.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  sync.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  sync.existing_remote_files = 'delete'
  sync.gzip_compression = true
end

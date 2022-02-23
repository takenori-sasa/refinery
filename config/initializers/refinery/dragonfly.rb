# encoding: utf-8
Refinery::Dragonfly.configure do |config|

  # Should set this if concerned about DOS attacks. See
  # http://markevans.github.com/dragonfly/file.Configuration.html#Configuration

  # config.secret       = "4b4e33638b893e99e6dcf89d9d9ff4c4a2c5c7b17d64d44e"
  # config.verify_urls  = true

  # Refinery passes all options to Dragonfly. See refinerycms/dragonfly/lib/refinery/dragonfly/configuration.rb and
  # http://markevans.github.com/dragonfly/file.Configuration.html#Configuration

  # config.url_format           = "/system/refinery/dragonfly/:job/:basename.:ext"
  # config.url_host             = ""
  # config.url_path_prefix      = ""

  # config.allow_legacy_urls    = false
  # config.analysers            = []
  # config.before_serve         = nil
  # config.datastore_root_path  = "public/system/refinery/dragonfly"
  # config.define_url           = nil
  # config.dragonfly_url        = nil
  # config.fetch_file_whitelist = nil
  # config.fetch_url_whitelist  = nil
  # config.generators           = []
  # config.mime_types           = []
  # config.name                 = "dragonfly"
  # config.path_prefix          = nil
  # config.plugin               = ""
  # config.processors           = []
  # config.response_header      = nil


  # Set the S3 options using means other than securely by environment variables.
  # If you have to.
  config.s3_bucket_name = ENV['S3_BUCKET']
  config.s3_region = ENV['S3_REGION']
  config.s3_access_key_id = ENV['S3_KEY']
  config.s3_secret_access_key = ENV['S3_SECRET']

  # When true will use Amazon's Simple Storage Service instead of the default file system for storing resources and images
  config.s3_datastore = config.s3_access_key_id.present? || config.s3_secret_access_key.present?

  # config.s3_fog_storage_options = nil
  # config.s3_root_path           = nil
  # config.s3_storage_path        = nil
  # config.s3_storage_headers     = nil
  # config.s3_url_host            = nil
  # config.s3_url_scheme          = nil
  # config.s3_use_iam_profile     = nil

  # Configure a custom Dragonfly datastore instead of the default (filesystem).
  # Dragonfly offers gems for datastores on S3, Couch, Mongo
  # See http://markevans.github.io/dragonfly/data-stores#building-a-custom-data-store
  #
  # config.custom_datastore_class = nil
  # config.custom_datastore_opts  = {}

end

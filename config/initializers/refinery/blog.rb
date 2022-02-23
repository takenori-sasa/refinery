Refinery::Blog.configure do |_config|
  # config.validate_source_url = false

  # config.comments_per_page = 10

  # config.posts_per_page = 10

  _config.post_teaser_length = 100

  # config.share_this_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

  # config.page_url = "/blog"

  # If you're grafting onto an existing app, change this to your User class
  # (eg: Refinery::Blog.user_class = "Refinery::Authentication::Devise::User" )
  Refinery::Blog.user_class = 'Refinery::Authentication::Devise::User'
end

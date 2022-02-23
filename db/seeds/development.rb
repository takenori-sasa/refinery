require 'factory_bot_rails'
require 'faker'
require 'gimei'
Refinery::I18n.frontend_locales.each do |_lang|
  I18n.locale = :en
  Faker::Config.locale = :en
  FactoryBot.create_list(:member, 50) if Refinery::Image.exists? and !Refinery::Members::Member.exists?
  FactoryBot.create_list(:blog_category, 10) unless Refinery::Blog::Category.exists?
  Refinery::Blog::Category::Translation.update_all(locale: 'ja')

  FactoryBot.create_list(:blog_post, 50) unless Refinery::Blog::Post.exists?
  Refinery::Blog::Post::Translation.update_all(locale: 'ja')
end

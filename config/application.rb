require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # 日本時間にする
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
    # config.i18n.default_locale = :ja

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # factorybot用設定
    config.generators do |g|
      # Railsジェネレータがfactory_bot用のファイルを生成するのを無効化
      g.factory_bot false

      # ファクトリファイルの置き場を変更
      g.factory_bot dir: 'spec/factories'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Refinery::Core::Engine.after_inclusion do
      Refinery::Resource # force autoload

      Dragonfly.app(:refinery_resources).response_header('Content-Disposition', nil)
    end
    Refinery::Core::Engine.config.to_prepare do
      ActionView::Base.field_error_proc = proc do |html_tag, instance|
        if html_tag.match?(/<(input|textarea)/)
          html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
          html_field.children.add_class 'is-invalid'
          class_name = instance.object.class.name.underscore
          method_name = instance.instance_variable_get(:@method_name)
          "#{html_field}<div class=\"invalid-feedback\">#{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}#{instance.error_message.first}</div>".html_safe
        else
          html_tag.html_safe
        end
      end
    end
  end
end

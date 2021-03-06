module Refinery
  module Members
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Members

      engine_name :refinery_members

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "members"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.members_admin_members_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Members)
      end
    end
  end
end

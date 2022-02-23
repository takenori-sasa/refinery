module Refinery
  module Pages
    class BootstrapNavbarMenuPresenter < MenuPresenter
      config_accessor :list_dropdown_css, :list_item_dropdown_css, :list_tag_css

      # Options:
      # * *:menu_tag* - A wrapper for the lists
      # * *:dom_id* - The dom id for the wrapper
      # * *:css* - The css class for the wrapper
      # * *:list_dropdown_css* - The css class of the submenu list
      # * *:list_item_dropdown_css* - The css class of the main menu item that has a dropdown
      # * *:list_tag_css* - The css class of the main menu
      # * *:active_css* - The css class denoting a active menu item
      # * *:selected_css* - The css class denoting a current menu item
      # <div class="collapse navbar-collapse" id=>
      self.menu_tag = :div
      self.dom_id = 'navbarNavDropdown'
      self.css = 'collapse navbar-collapse'
      self.list_dropdown_css = 'list_dropdown'
      self.list_item_dropdown_css = 'dropdown'
      self.list_tag_css = 'navbar-nav mr-auto' # 一番外側のcss
      self.active_css = 'active'
      self.selected_css = 'active'

      private

      def has_dropdown_item?(menu_item)
        (menu_item != roots.first) && (menu_item_children(menu_item).count >
          0)
      end

      def menu_items_css(menu_items) # <ul>用class
        css = []

        css << if roots == menu_items # 多分rootsはリストとかsetとか何か ←で一層目かを判断できる
                 list_tag_css
               else
                 'dropdown-menu'
               end
        css.reject(&:blank?).presence
      end

      def menu_item_css(menu_item, _index) # <li>用class
        css = ['nav-item']

        css << active_css if descendant_item_selected?(menu_item)
        css << selected_css if selected_item?(menu_item)
        css << list_item_dropdown_css if has_dropdown_item?(menu_item)
        # css << first_css if index == 0
        # css << last_css if index == menu_item.shown_siblings.length

        css.reject(&:blank?).presence
      end

      def link_to_css(menu_item) # link_toつまり<a>に仕込むcss
        css = []

        css << ('dropdown-toggle' if has_dropdown_item?(menu_item))
        css << if menu_item.depth.zero?
                 'nav-link'
               else
                 'dropdown-item'
               end
        css.reject(&:blank?).presence
      end

      def render_link_to(menu_item)
        if has_dropdown_item?(menu_item)
          link_to(menu_item.title, context.refinery.url_for(menu_item.url),
                  class: link_to_css(menu_item), id: 'navbarDropdownMenuLink', role: 'button', 'data-toggle': 'dropdown', 'aria-haspopup': 'true', 'aria-expanded': 'false')
        else
          link_to(menu_item.title, context.refinery.url_for(menu_item.url),
                  class: link_to_css(menu_item))
        end
      end

      def render_menu(items) # 一番外のrender
        render_menu_items(items)
      end

      def render_menu_items(menu_items) # <ul>作る
        return if menu_items.blank?

        if roots == menu_items
          content_tag(list_tag, class: menu_items_css(menu_items)) do # <ul>作ってる
            menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
              buffer << render_menu_item(item, index)
            end
          end
        else
          content_tag(:div, class: menu_items_css(menu_items), 'aria-labelledby': 'navbarDropdownMenuLink') do # <ul>作ってる
            menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, _index)|
              buffer << render_link_to(item)
            end
          end
        end
      end

      def render_menu_item(menu_item, index) # <li>作る
        content_tag(list_item_tag, class: menu_item_css(menu_item,
                                                        index)) do # <li>作ってる
          @cont = context.refinery.url_for(menu_item.url)
          buffer = ActiveSupport::SafeBuffer.new
          buffer << render_link_to(menu_item)
          buffer << render_menu_items(menu_item_children(menu_item)) # 子ページがあったら<ul>作ってる
          buffer
        end
      end
    end
  end
end

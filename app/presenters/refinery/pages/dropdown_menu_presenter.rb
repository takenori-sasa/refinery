module Refinery
  module Pages
    class DropdownMenuPresenter < MenuPresenter
      config_accessor :list_dropdown_css, :list_item_dropdown_css, :list_tag_css, :link_css
      # 最外殻につく
      self.menu_tag = nil # これがnilだと中の<ul>がむき出し
      self.dom_id = nil
      self.css = nil
      # <ul>に付く
      self.list_dropdown_css = 'dropdown' # 子カテゴリをくるんでる<ul>につくclass
      # ※<ul>は一番外じゃなかったらdropdown持ちにしか現れない
      self.list_tag_css = nil # 一番外側の<ul>につくclass
      # <li>につく
      self.list_item_dropdown_css = 'has-dropdown' # 子カテゴリを持つ<li>につくclass
      # <a>につく
      self.link_css = nil
      # <ul>,<li>どちらにもつく
      self.first_css = :first # 同階層のアイテムで先頭だったら付く
      self.last_css = :last # 同階層のアイテムで最後だったら付く
      self.active_css = 'active' # 選択されてたら付く
      self.selected_css = 'active' # activeとなにかが違うはずだけどわからない

      private

      def render_menu(items)
        if menu_tag
          content_tag(menu_tag, id: dom_id, class: css) do
            render_menu_items(items)
          end
        else
          render_menu_items(items)
        end
      end

      def render_menu_items(menu_items)
        return if menu_items.blank?

        content_tag(list_tag, class: menu_items_css(menu_items)) do
          menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_menu_item(item, index)
          end
        end
      end

      def check_for_dropdown_item(menu_item)
        menu_item_children(menu_item).count.positive?
      end

      def menu_items_css(menu_items)
        css = []

        css << if roots == menu_items
                 list_tag_css
               else
                 list_dropdown_css
               end

        css.reject(&:blank?).presence
      end

      def menu_item_css(menu_item, index)
        css = []

        css << active_css if descendant_item_selected?(menu_item)
        css << selected_css if selected_item?(menu_item)
        css << list_item_dropdown_css if check_for_dropdown_item(menu_item)
        css << first_css if index == 0
        css << last_css if index == menu_item.shown_siblings.length

        css.reject(&:blank?).presence
      end

      def render_menu_item(menu_item, index)
        content_tag(list_item_tag, class: menu_item_css(menu_item,
                                                        index)) do
          @cont = context.refinery.url_for(menu_item.url)
          buffer = ActiveSupport::SafeBuffer.new
          buffer << link_to(menu_item.title, context.refinery.url_for(menu_item.url), class: link_css)
          buffer << render_menu_items(menu_item_children(menu_item))
          buffer
        end
      end
    end
  end
end

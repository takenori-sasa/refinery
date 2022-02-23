module ApplicationHelper
  # Creates a dropdown menu with items matching Refinery pages
  # and tags/css matching Foundation markup
  #

  def navbar_menu(items, _options = {})
    Refinery::Pages::BootstrapNavbarMenuPresenter.new(items, self)
  end

  def footer_menu(_options = {})
    items = Refinery::Menu.new(Refinery::Page.footer_menu_pages)
    presenter = Refinery::Pages::DropdownMenuPresenter.new(items, self)
    # # 以下option
    # # デフォルトはapp/presenters/refinery/pages/dropdown_menu_presenter.rbに記載
    # # 下2つは<ul>に付く
    # presenter.list_dropdown_css = 'dropdown' # 子カテゴリをくるんでる<ul>につくclass
    # presenter.list_tag_css = nil # <ul>につくclass
    # # 下1つは<li>につく
    # presenter.list_item_dropdown_css = 'has-dropdown' # 子カテゴリを持つ<li>につくclass
    # # 下4つは<ul>,<li>どちらにもつく
    presenter.first_css = nil # 同階層のアイテムで先頭だったら付く
    presenter.last_css = nil # 同階層のアイテムで最後だったら付く
    # presenter.active_css = 'active' # 選択されてたら付く
    # presenter.selected_css = 'active' # activeとなにかが違うはずだけどわからない
    # # 最後は<a>につく
    # presenter.link_css = nil
    %w[menu_tag dom_id css list_tag_css active_css selected_css link_css].map(&:to_sym).each do |k|
      presenter.send("#{k}=", _options[k]) if _options.has_key?(k)
    end
    presenter
  end

  def curved(str)
    str = str.tr('A-Za-z', "\u{1D49C}-\u{1D4CF}")
    str.tr("\u{1D49D}\u{1D4A0}\u{1D4A1}\u{1D4A3}\u{1D4A4}\u{1D4A7}\u{1D4A8}\u{1D4AD}\u{1D4BA}\u{1D4BC}\u{1D4C4}",
           "\u{212C}\u{2130}\u{2131}\u{210B}\u{2110}\u{2112}\u{2133}\u{211B}\u{212F}\u{210A}\u{2134}")
  end
end

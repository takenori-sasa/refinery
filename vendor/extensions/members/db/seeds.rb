Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.find_each do |user|
      user.plugins.where(name: 'refinerycms-members').first_or_create!(
        position: (user.plugins.maximum(:position) || -1) + 1
      )
    end
  end

  next unless defined?(Refinery::Page)

  Refinery::Page.where(link_url: (url = '/members')).first_or_create!(
    title: 'Members',
    deletable: false,
    menu_match: "^#{url}(\/|\/.+?|)$"
  ) do |page|
    Refinery::Pages.default_parts.each_with_index do |part, index|
      page.parts.build title: part[:title], slug: part[:slug], body: nil, position: index
    end
  end
end

module Refinery::Blog::PostsHelper
  module ExtendWidget
    def recent_link(year, month, count)
      link_to "#{t('date.year_name', year: year)}#{t('date.month_names')[month]}(#{count})",
              refinery.blog_archive_posts_path(year: year, month: month)
    end
            def old_link(year, count)
          link_to "#{t('date.year_name', year: year)}(#{count})", refinery.blog_archive_posts_path(:year => year)
        end

  end

  class ArchiveWidget
    prepend ExtendWidget
  end
end

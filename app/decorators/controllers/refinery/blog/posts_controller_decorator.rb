module Refinery::Blog
  PostsController.class_eval do
    def archive
      if params[:month].present?
        date = "#{params[:month]}/#{params[:year]}"
        archive_date = Time.parse(date)
        @date_title = ::I18n.l(archive_date, format: :middle)
        @posts = Post.live.by_month(archive_date).page(params[:page])
      else
        date = "01/#{params[:year]}"
        archive_date = Time.parse(date)
        @date_title = ::I18n.l(archive_date, format: :middle)
        @posts = Post.live.by_year(archive_date).page(params[:page])
      end
      respond_with(@posts)
    end
  end
end

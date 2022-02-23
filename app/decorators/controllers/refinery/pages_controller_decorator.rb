Refinery::PagesController.class_eval do
  before_action :find_random_members, :find_about_page, :find_lateset_blog_posts, :find_blog_page, :find_contact_page,
                only: [:home]

  helper Refinery::Blog::PostsHelper

  protected

  def find_random_members
    @random_members = ::Refinery::Members::Member.all.sample(8)
  end

  def find_about_page
    @about = ::Refinery::Page.where(slug: 'about').first
  end

  def find_lateset_blog_posts
    @blog_posts = Refinery::Blog::Post.where(draft: false).order(published_at: :desc).limit(6)
  end

  def find_blog_page
    @blog = ::Refinery::Page.where(link_url: '/blog').first
  end

  def find_contact_page
    @contact = ::Refinery::Page.where(link_url: '/contact').first
  end
end

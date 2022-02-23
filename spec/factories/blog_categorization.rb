FactoryBot.define do
  factory :blog_categorization, class: Refinery::Blog::Categorization do
    blog_category_id {Refinery::Blog::Category.pluck(:id).sample}
    blog_post_id {Refinery::Blog::Post.pluck(:id).sample}
  end
end

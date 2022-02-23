FactoryBot.define do
  factory :blog_post, class: Refinery::Blog::Post do
    sequence(:title) { |n| "#{n} " + Faker::Lorem.sentence }
    body { Faker::Lorem.paragraphs.join(' ') }
    draft { false }
    published_at { Faker::Time.between(from: 3.year.ago, to: DateTime.now) }
    username { Gimei.last.romaji }
    author { Refinery::Authentication::Devise::User.all.sample }

    factory :blog_post_draft do
      draft { true }
    end
  end
end

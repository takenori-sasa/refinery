FactoryBot.define do
  factory :member, class: Refinery::Members::Member do
    transient do
      namae { Gimei.name }
    end
    sequence(:blurb) { |n| "Top #{n} " + Faker::Lorem.sentence }
    name { namae.kanji }
    romanized_name { namae.last.romaji + ' ' + namae.first.romaji }
    occupation { Refinery::Members::Member::OCCUPATIONS.sample }
    university { Gimei.address.prefecture.to_s + '立大学' }
    photo_id { Refinery::Image.any? ? Refinery::Image.pluck(:id).sample : nil }
  end
end

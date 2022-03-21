FactoryBot.define do
  factory :buy_order do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { '777-7777' }
    prefecture_id { Faker::Number.within(range: 1..47) }
    city { Gimei.address.city.kanji }
    address { Gimei.address.town.kanji }
    building_name { '青山ビル301' }
    phone_number { '08098987878' }
  end
end

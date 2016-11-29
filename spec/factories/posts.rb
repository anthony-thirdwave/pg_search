FactoryGirl.define do
  factory :post do
    title { Faker::Name.name }
    body { Faker::Lorem.paragraphs }
  end
end

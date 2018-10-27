FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    country { Faker::Address.country }
    state { Faker::Address.state }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    zip { Faker::Address.zip }
    address { Faker::Address.street_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :admin do
      admin true
    end

    trait :moderator do
      moderator true
    end

    factory :admin_user, traits: [:admin]
    factory :moderator_user, traits: [:moderator]
  end

  factory :advert do
    description { Faker::Lorem.paragraph }
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test_image.jpg')))

    user

    factory :advert_with_comment do
      after(:create) do |advert|
        create(:comment, content: "Some sentence", advert: advert)
      end
    end
  end

  factory :comment do
    content { Faker::Lorem.sentence }

    user
    advert
  end
end
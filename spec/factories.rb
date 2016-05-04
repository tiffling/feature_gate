FactoryGirl.define do
  factory :gated_feature, class: 'FeatureGate::GatedFeature' do
    sequence(:name){ |n| "name_#{n}" }
    gated true

    trait :open do
      gated false
    end
  end
end

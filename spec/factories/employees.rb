FactoryBot.define do
  factory :employee do
    sequence(:firstname) { |n| "FirstName#{n}" }
    sequence(:lastname) { |n| "LastName#{n}" }
    sequence(:email) { |n| "employee#{n}@example.com" }
    sequence(:phone) { |n| "555-#{n.to_s.rjust(4, '0')}" }
    salary { rand(40000..150000) }
    haspassport { [true, false].sample }
    birthdate { rand(25..65).years.ago.to_date }
    hiredate { rand(1..10).years.ago.to_date }
    gender { ['Male', 'Female', 'Non-binary'].sample }
    notes { "Test employee notes" }

    association :country
    association :department
  end
end


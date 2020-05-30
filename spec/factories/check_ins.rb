FactoryBot.define do
  factory :check_in do
    # Faker is used for mocking data
    date_submitted { Faker::Date.between(from: 7.days.ago, to: Date.today) } 
    mood { Faker::Number.number(digits: 2) } # number takes argument of length of the number
    nutrition_rating { Faker::Number.number(digits: 2) }
    cups_of_water { Faker::Number.number(digits: 2) }
    activity_rating { Faker::Number.number(digits: 2) }
    sleep_hours { Faker::Number.number(digits: 2) }
    did_meditate { Faker::Boolean.boolean }
    meditation_rating { Faker::Number.number(digits: 2) }
    created_by { Faker::Number.number(digits: 2) }
  end
end

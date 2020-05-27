FactoryBot.define do
  factory :check_in do
    date_submitted { "2020-05-26" }
    mood { 1 }
    nutrition { 1 }
    water { 1 }
    activity { 1 }
    sleep { 1 }
    didMeditate { false }
    meditationRanking { 1 }
    createdBy { 1 }
  end
end

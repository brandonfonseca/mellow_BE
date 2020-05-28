# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  # Validation tests
  it { should validate_presence_of(:date_submitted) }
  it { should validate_presence_of(:mood) }
  it { should validate_presence_of(:nutrition_rating) }
  it { should validate_presence_of(:cups_of_water) }
  it { should validate_presence_of(:activity_rating) }
  it { should validate_presence_of(:sleep_hours) }
  it { should validate_presence_of(:did_meditate) }
end

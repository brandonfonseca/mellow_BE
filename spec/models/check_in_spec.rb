require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  # Validation tests
  it { should validate_presence_of(:date_submitted) }
  it { should validate_presence_of(:mood) }
  it { should validate_presence_of(:nutrition) }
  it { should validate_presence_of(:water) }
  it { should validate_presence_of(:activity) }
  it { should validate_presence_of(:sleep) }
  it { should validate_presence_of(:did_meditate) }
  it { should validate_presence_of(:meditation_ranking) }

end

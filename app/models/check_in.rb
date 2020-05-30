# frozen_string_literal: true

class CheckIn < ApplicationRecord
  validates_presence_of :date_submitted, :mood, :nutrition_rating, :cups_of_water,
                        :activity_rating, :sleep_hours
end

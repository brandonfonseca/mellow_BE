# frozen_string_literal: true

class CheckIn < ApplicationRecord
  validates_presence_of :date_submitted, :mood, :nutrition, :water,
                        :activity, :sleep, :did_meditate, :meditation_ranking
end

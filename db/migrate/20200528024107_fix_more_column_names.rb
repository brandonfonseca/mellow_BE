class FixMoreColumnNames < ActiveRecord::Migration[5.2]
  def change
    change_table :check_ins do |t|
      t.rename(:nutrition, :nutrition_rating)
      t.rename(:water, :cups_of_water)
      t.rename(:activity, :activity_rating)
      t.rename(:meditation_ranking, :meditation_rating)
    end
  end
end

class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins do |t|
      t.date :date_submitted
      t.integer :mood
      t.integer :nutrition
      t.integer :water
      t.integer :activity
      t.integer :sleep
      t.boolean :did_meditate
      t.integer :meditation_ranking
      t.integer :created_by

      t.timestamps
    end
  end
end

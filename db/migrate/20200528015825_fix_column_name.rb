class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :check_ins, :sleep, :sleep_hours
  end
end

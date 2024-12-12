class UpdateEvents < ActiveRecord::Migration[7.0]
  def up
    change_column :events, :end_time, :datetime, null: false
  end

  def down
    change_column :events, :end_time, :datetime, null: true
  end
end



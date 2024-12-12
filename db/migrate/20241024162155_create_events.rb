class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.string :location
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.timestamps
    end
  end
end

class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.boolean :event_role, default: false
      t.string :qr_code_value
      t.timestamps
    end
  end
end

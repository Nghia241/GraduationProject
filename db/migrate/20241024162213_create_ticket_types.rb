class CreateTicketTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_types do |t|
      t.string :type_name, null: false
      t.text :description
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end

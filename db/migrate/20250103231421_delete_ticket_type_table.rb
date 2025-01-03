class DeleteTicketTypeTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :ticket_types
  end
end

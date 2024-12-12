class AddRelationsToTickets < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:tickets, :user_id)
      add_reference :tickets, :user, null: false, foreign_key: true
    end
    unless column_exists?(:tickets, :event_id)
      add_reference :tickets, :event, null: false, foreign_key: true
    end
    add_column :tickets, :event_role, :boolean, default: false unless column_exists?(:tickets, :event_role)
    add_column :tickets, :qr_code_value, :string unless column_exists?(:tickets, :qr_code_value)
  end
end


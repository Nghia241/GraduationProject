class AddCheckedInToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :checked_in, :boolean, default: false, null: false
  end
end

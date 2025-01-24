class ChangeEventRoleToIntegerInTickets < ActiveRecord::Migration[7.0]
  def up
    change_column :tickets, :event_role, :integer
  end

  def down
    change_column :tickets, :event_role, :boolean
  end
end

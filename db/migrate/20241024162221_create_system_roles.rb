class CreateSystemRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :system_roles do |t|
      t.string :role_name, null: false
      t.text :description
      t.timestamps
    end
    add_foreign_key :users, :system_roles
  end
end

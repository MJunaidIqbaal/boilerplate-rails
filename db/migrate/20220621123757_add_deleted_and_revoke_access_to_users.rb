class AddDeletedAndRevokeAccessToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deleted, :boolean, default: false
    add_column :users, :revoke_access, :boolean, default: false
  end
end

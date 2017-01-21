class AddInactiveAtToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :inactive_at, :timestamp
  end
end

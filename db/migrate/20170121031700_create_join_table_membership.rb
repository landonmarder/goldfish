class CreateJoinTableMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end

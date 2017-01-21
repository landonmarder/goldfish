class CreateGroupActivities < ActiveRecord::Migration
  def change
    create_table :group_activities do |t|
      t.timestamp :completed_at
      t.timestamps null: false
    end
  end
end

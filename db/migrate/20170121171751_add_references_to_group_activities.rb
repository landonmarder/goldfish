class AddReferencesToGroupActivities < ActiveRecord::Migration
  def change
    add_reference :group_activities, :activity, index: true
    add_reference :group_activities, :group, index: true
  end
end

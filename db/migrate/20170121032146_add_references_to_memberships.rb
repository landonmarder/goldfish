class AddReferencesToMemberships < ActiveRecord::Migration
  def change
    add_reference :memberships, :user, index: true
    add_reference :memberships, :group, index: true
  end
end

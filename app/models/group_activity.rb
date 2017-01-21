class GroupActivity < ActiveRecord::Base
  belongs_to :group, inverse_of: :group_activities
  belongs_to :activity, inverse_of: :group_activities

  delegate :title, :description, to: :activity
end

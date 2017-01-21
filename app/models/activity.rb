class Activity < ActiveRecord::Base
  has_many :group_activities, inverse_of: :activity
end

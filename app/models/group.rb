class Group < ActiveRecord::Base
  has_many :memberships, inverse_of: :group
  has_many :users, through: :memberships
  has_many :group_activities, inverse_of: :group
  has_many :activities, through: :group_activities
end

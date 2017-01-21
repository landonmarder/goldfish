class Group < ActiveRecord::Base
  has_many :memberships, inverse_of: :group
  has_many :users, through: :memberships
end

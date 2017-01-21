class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  default_scope { where(inactive_at: nil) }
end

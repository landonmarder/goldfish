class MembershipsController < ApplicationController
  before_filter :authenticate

  def index
    @group = Group.find(params[:group_id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path
    end

    @memberships = @group.memberships.includes(:user)
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.inactive_at ||= Time.now
    membership.save

    redirect_to group_memberships_path(group_id: params[:group_id])
  end
end

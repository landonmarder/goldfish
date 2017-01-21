class MembershipsController < ApplicationController
  before_filter :authenticate

  def index
    @group = Group.find(params[:group_id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path
    end

    @memberships = @group.memberships.includes(:user)
  end
end

class GroupActivitiesController < ApplicationController
  before_filter :authenticate

  def index
    @group = Group.find(params[:group_id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path
    end

    @group_activities = @group.group_activities.includes(:activity)
  end
end

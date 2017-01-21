class GroupActivitiesController < ApplicationController
  before_filter :authenticate

  def index
    @group = Group.find(params[:group_id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path
    end

    @group_activities = @group.group_activities.includes(:activity)
  end

  def create
    @group = Group.find(params[:group_id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path and return
    end

    if @group.group_activities.create(group_activity_params)
      flash[:success] = "Successfully added the activity!"
    else
      flash[:errors] = "Be more detailed than just there was an error"
    end

    redirect_to group_group_activities_path(@group)
  end

  def update
    @group = Group.find(params[:group_id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path and return
    end

    @group_activity = @group.group_activities.find(params[:id])

    if @group_activity.update(group_activity_params)
      flash[:success] = "Successfully updated the activity!"
    else
      flash[:errors] = "Be more detailed than just there was an error"
    end

    redirect_to group_group_activities_path(@group)
  end

  def destroy
    group_activity = GroupActivity.find(params[:id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path and return
    end

    group_activity.destroy!
    redirect_to group_memberships_path(group_id: params[:group_id])
  end

  private

  def group_activity_params
    params.require(:group_activity).permit(:activity_id, :completed_at)
  end
end
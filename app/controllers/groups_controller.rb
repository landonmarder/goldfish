class GroupsController < ApplicationController
  before_filter :authenticate, except: :index

  def index
    if current_user
      @groups = current_user.groups
    end
  end

  def show
    @group = current_user.groups.find_by(id: params[:id])

    unless current_user.groups.include?(@group)
      redirect_to groups_path
    end
  end
end

class GroupsController < ApplicationController
  before_filter :authenticate

  def index
    @groups = current_user.groups
  end
end

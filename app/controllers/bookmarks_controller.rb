class BookmarksController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /bookmarks
  # GET /bookmarks.jison
  def index
    @topics = Topic.select('topics.*').includes(:user, :updater).with_roles.only_for_user(current_user).order('topics.updated_at desc').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end
end

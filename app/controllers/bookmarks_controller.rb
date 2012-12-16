class BookmarksController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @topics = Topic.select('topics.*').includes(:user, :updater).only_for_user(current_user).order('topics.updated_at desc').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  # DELETE /bookmarks
  def clear
    Bookmark.where(:user_id => current_user.id).each do |b|
      b.update_attribute :message_id, b.topic.last_message_id
    end

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end
end

class NotificationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /notifications
  # GET /notifications.json
  def index
    @messages = current_user.notified_messages.select('messages.*').includes(:user, :small_messages).with_follows(current_user).order('messages.updated_at desc').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  # DELETE /notifications
  def clear
    Notification.where(:user_id => current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end
end

class NotificationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /notifications
  # GET /notifications.json
  def index
    @folded = true
    @meta = true
    @messages = current_user.notified_messages.select('messages.*, notifications.id as notification_id').includes(:topic, :user, :small_messages => :user).with_follows(current_user).order('notifications.id desc').page(params[:page])

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

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end
end

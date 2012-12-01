class NotificationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /notifications
  # GET /notifications.json
  def index
    @messages = current_user.notified_messages.select('messages.*').includes(:user, :small_messages).with_follows(current_user).order(:updated_at).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end
end

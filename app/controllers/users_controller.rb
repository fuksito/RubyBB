class UsersController < ApplicationController
  before_filter :check_params, :only => [:index]
  helper_method :default_column, :default_direction

  # GET /users
  # GET /users.json
  def index
    @users = User.where(params[:sort] + " <> ''").order(params[:sort] + " " + params[:direction]).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, :except => [:email] }
    end
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user, :except => [:email] }
    end
  end

  private

  def default_column
    'created_at'
  end

  def default_direction column
    %w[topics_count messages_count updated_at].include?(column) ? 'desc' : 'asc'
  end

  def check_params
    params[:sort] = default_column unless User.column_names.include?(params[:sort])
    params[:direction] = default_direction(params[:sort]) unless %w[asc desc].include?(params[:direction])
  end

end

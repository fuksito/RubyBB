class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

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
    @widgets_mode = true
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user, :except => [:email] }
    end
  end

  # PUT /users/1/roles
  def roles
    @user = User.find(params[:id])

    params[:roles].each do |array|
      forum_id, name = array
      r = Role.new user_id: @user.id, forum_id: forum_id, name: name
      authorize! :manage, r
      @user.roles.where(forum_id: forum_id).delete_all
      r.save unless name == 'user'
    end

    respond_to do |format|
      format.html { render action: 'show' }
      format.json { render json: @user.roles, :except => [:email] }
    end
  end

  # PUT /users/1/bot
  def bot
    @user = User.find(params[:id])
    authorize! :bot, @user

    if params[:bot]
      @user.messages.delete_all
      @user.delete
    elsif params[:human]
      @user.update_column :human, true
    end

    respond_to do |format|
      format.html { render action: 'show' }
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

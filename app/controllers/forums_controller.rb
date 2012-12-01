class ForumsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :get_stats, :only => :index

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.includes(:updater)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    @pinnable = true
    @forum = Forum.select('forums.*').with_follows(current_user).find(params[:id])
    @topics = @forum.topics.select('topics.*').includes(:user, :updater).with_roles.for_user(current_user).order('topics.pinned desc, topics.updated_at desc').page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.json
  def new
    @forum = Forum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        format.html { redirect_to forums_url, notice: 'Forum was successfully created.' }
        format.json { render json: @forum, status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/position
  def position
    i = 1
    params[:forums].each do |f|
      if f.present?
        Forum.find(f.to_i).update_column :position, i
        i = i + 1
      end
    end

    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :no_content }
    end
  end

  # PUT /forums/1
  # PUT /forums/1.json
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to forums_url, notice: 'Forum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :no_content }
    end
  end

  private
  def get_stats
    @users = User.where('updated_at >= ?', 5.minutes.ago)
  end
end

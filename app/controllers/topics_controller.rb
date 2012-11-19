class TopicsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!, :except => [:show]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @messages = @topic.messages.page params[:page]
    @message = Message.new topic_id: @topic.id

    if current_user && current_user.id != @topic.viewer_id && @topic.last_page?(params[:page])
      @topic.update_column :viewer_id, current_user.id
      @topic.update_column :views_count, @topic.views_count+1
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new forum_id: params[:forum_id]
    @topic.messages.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    params[:topic][:user_id] = current_user.id
    params[:topic][:messages_attributes]['0'][:user_id] = current_user.id
    params[:topic][:messages_attributes]['0'][:forum_id] = params[:topic][:forum_id]
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        @topic.update_column :updater_id, current_user.id
        format.html { redirect_to forum_url(@topic.forum), notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    params[:topic].delete :user_id
    params[:topic].delete :messages_attributes
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to forum_url(@topic.forum), notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    forum = @topic.forum
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to forum_url(forum) }
      format.json { head :no_content }
    end
  end
end

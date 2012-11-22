class MessagesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    begin
      @messages = Message.search(params[:q], page: params[:page], load: true)
    rescue
      flash[:error] = I18n.t('search.error')
      @messages = []
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new topic_id: params[:topic_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    params[:message][:user_id] = current_user.id
    params[:message][:forum_id] = Topic.find(params[:message][:topic_id]).forum_id
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        @message.topic.update_column :last_message_id, @message.id
        @message.topic.update_column :updater_id, current_user.id
        @message.forum.update_column :updater_id, current_user.id
        format.html { redirect_to topic_url(@message.topic, page: Topic.find(@message.topic_id).messages.page.num_pages), notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])
    params[:message].delete :user_id
    params[:message].delete :forum_id

    respond_to do |format|
      if @message.update_attributes(params[:message])
        @message.update_column :updater_id, current_user.id
        format.html { redirect_to topic_url(@message.topic, page: params[:page]), notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    if(@message == @message.topic.messages.first)
      r = forum_url(@message.forum)
      @message.topic.destroy
    else
      r = topic_url(@message.topic)
      @message.destroy
    end

    respond_to do |format|
      format.html { redirect_to r }
      format.json { head :no_content }
    end
  end
end

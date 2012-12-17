class SmallMessagesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  # GET /small_messages
  # GET /small_messages.json
  def index
    @small_messages = SmallMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @small_messages }
    end
  end

  # GET /small_messages/1
  # GET /small_messages/1.json
  def show
    @small_message = SmallMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @small_message }
    end
  end

  # GET /small_messages/new
  # GET /small_messages/new.json
  def new
    @small_message = SmallMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @small_message }
    end
  end

  # GET /small_messages/1/edit
  def edit
    @small_message = SmallMessage.find(params[:id])
  end

  # POST /small_messages
  # POST /small_messages.json
  def create
    @small_message = SmallMessage.new(params[:small_message])
    message = Message.find(@small_message.message_id)
    @small_message.user_id = current_user.id
    @small_message.topic_id = message.topic_id
    @small_message.forum_id = message.forum_id

    respond_to do |format|
      if @small_message.save
        format.html { redirect_to topic_url(message.topic, page: params[:page], anchor: "m#{message.id}"), notice: 'Small message was successfully created.' }
        format.json { render json: @small_message, status: :created, location: @small_message }
        format.js
      else
        format.html { redirect_to topic_url(message.topic, page: params[:page], anchor: "m#{message.id}") }
        format.json { render json: @small_message.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /small_messages/1
  # PUT /small_messages/1.json
  def update
    @small_message = SmallMessage.find(params[:id])

    respond_to do |format|
      if @small_message.update_attributes(params[:small_message])
        format.html { redirect_to @small_message, notice: 'Small message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @small_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /small_messages/1
  # DELETE /small_messages/1.json
  def destroy
    @small_message = SmallMessage.find(params[:id])
    topic = @small_message.topic
    message_id = @small_message.message_id
    @small_message.destroy

    respond_to do |format|
      format.html { redirect_to topic_url(topic, page: params[:page], anchor: "m#{message_id}") }
      format.json { head :no_content }
      format.js { head :no_content }
    end
  end
end

require 'test_helper'

class SmallMessagesControllerTest < ActionController::TestCase
  setup do
    @small_message = small_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:small_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create small_message" do
    assert_difference('SmallMessage.count') do
      post :create, small_message: { content: @small_message.content }
    end

    assert_redirected_to small_message_path(assigns(:small_message))
  end

  test "should show small_message" do
    get :show, id: @small_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @small_message
    assert_response :success
  end

  test "should update small_message" do
    put :update, id: @small_message, small_message: { content: @small_message.content }
    assert_redirected_to small_message_path(assigns(:small_message))
  end

  test "should destroy small_message" do
    assert_difference('SmallMessage.count', -1) do
      delete :destroy, id: @small_message
    end

    assert_redirected_to small_messages_path
  end
end

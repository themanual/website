require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get featured" do
    get :featured
    assert_response :success
  end

  test "should get subscriptions" do
    get :subscriptions
    assert_response :success
  end

  test "should get collections" do
    get :collections
    assert_response :success
  end

  test "should get issues" do
    get :issues
    assert_response :success
  end

  test "should get goods" do
    get :goods
    assert_response :success
  end

end

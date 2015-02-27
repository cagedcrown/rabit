require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get study" do
    get :study
    assert_response :success
  end

  test "should get stats" do
    get :stats
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end

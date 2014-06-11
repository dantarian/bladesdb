require 'test_helper'

class GameApplicationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_application" do
    assert_difference('GameApplication.count') do
      post :create, :game_application => { }
    end

    assert_redirected_to game_application_path(assigns(:game_application))
  end

  test "should show game_application" do
    get :show, :id => game_applications(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => game_applications(:one).to_param
    assert_response :success
  end

  test "should update game_application" do
    put :update, :id => game_applications(:one).to_param, :game_application => { }
    assert_redirected_to game_application_path(assigns(:game_application))
  end

  test "should destroy game_application" do
    assert_difference('GameApplication.count', -1) do
      delete :destroy, :id => game_applications(:one).to_param
    end

    assert_redirected_to game_applications_path
  end
end

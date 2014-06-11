require 'test_helper'

class DebriefsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debriefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debrief" do
    assert_difference('Debrief.count') do
      post :create, :debrief => { }
    end

    assert_redirected_to debrief_path(assigns(:debrief))
  end

  test "should show debrief" do
    get :show, :id => debriefs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => debriefs(:one).to_param
    assert_response :success
  end

  test "should update debrief" do
    put :update, :id => debriefs(:one).to_param, :debrief => { }
    assert_redirected_to debrief_path(assigns(:debrief))
  end

  test "should destroy debrief" do
    assert_difference('Debrief.count', -1) do
      delete :destroy, :id => debriefs(:one).to_param
    end

    assert_redirected_to debriefs_path
  end
end

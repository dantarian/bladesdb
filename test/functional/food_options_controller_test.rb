require 'test_helper'

class FoodOptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_option" do
    assert_difference('FoodOption.count') do
      post :create, :food_option => { }
    end

    assert_redirected_to food_option_path(assigns(:food_option))
  end

  test "should show food_option" do
    get :show, :id => food_options(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => food_options(:one).to_param
    assert_response :success
  end

  test "should update food_option" do
    put :update, :id => food_options(:one).to_param, :food_option => { }
    assert_redirected_to food_option_path(assigns(:food_option))
  end

  test "should destroy food_option" do
    assert_difference('FoodOption.count', -1) do
      delete :destroy, :id => food_options(:one).to_param
    end

    assert_redirected_to food_options_path
  end
end

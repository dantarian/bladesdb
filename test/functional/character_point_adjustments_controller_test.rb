require 'test_helper'

class CharacterPointAdjustmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:character_point_adjustments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create character_point_adjustment" do
    assert_difference('CharacterPointAdjustment.count') do
      post :create, :character_point_adjustment => { }
    end

    assert_redirected_to character_point_adjustment_path(assigns(:character_point_adjustment))
  end

  test "should show character_point_adjustment" do
    get :show, :id => character_point_adjustments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => character_point_adjustments(:one).to_param
    assert_response :success
  end

  test "should update character_point_adjustment" do
    put :update, :id => character_point_adjustments(:one).to_param, :character_point_adjustment => { }
    assert_redirected_to character_point_adjustment_path(assigns(:character_point_adjustment))
  end

  test "should destroy character_point_adjustment" do
    assert_difference('CharacterPointAdjustment.count', -1) do
      delete :destroy, :id => character_point_adjustments(:one).to_param
    end

    assert_redirected_to character_point_adjustments_path
  end
end

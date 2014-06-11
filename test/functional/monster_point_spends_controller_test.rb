require 'test_helper'

class MonsterPointSpendsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monster_point_spends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monster_point_spend" do
    assert_difference('MonsterPointSpend.count') do
      post :create, :monster_point_spend => { }
    end

    assert_redirected_to monster_point_spend_path(assigns(:monster_point_spend))
  end

  test "should show monster_point_spend" do
    get :show, :id => monster_point_spends(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => monster_point_spends(:one).to_param
    assert_response :success
  end

  test "should update monster_point_spend" do
    put :update, :id => monster_point_spends(:one).to_param, :monster_point_spend => { }
    assert_redirected_to monster_point_spend_path(assigns(:monster_point_spend))
  end

  test "should destroy monster_point_spend" do
    assert_difference('MonsterPointSpend.count', -1) do
      delete :destroy, :id => monster_point_spends(:one).to_param
    end

    assert_redirected_to monster_point_spends_path
  end
end

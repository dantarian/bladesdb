require 'test_helper'

class GuildMembershipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guild_memberships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guild_membership" do
    assert_difference('GuildMembership.count') do
      post :create, :guild_membership => { }
    end

    assert_redirected_to guild_membership_path(assigns(:guild_membership))
  end

  test "should show guild_membership" do
    get :show, :id => guild_memberships(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => guild_memberships(:one).to_param
    assert_response :success
  end

  test "should update guild_membership" do
    put :update, :id => guild_memberships(:one).to_param, :guild_membership => { }
    assert_redirected_to guild_membership_path(assigns(:guild_membership))
  end

  test "should destroy guild_membership" do
    assert_difference('GuildMembership.count', -1) do
      delete :destroy, :id => guild_memberships(:one).to_param
    end

    assert_redirected_to guild_memberships_path
  end
end

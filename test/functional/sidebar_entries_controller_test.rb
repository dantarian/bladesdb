require 'test_helper'

class SidebarEntriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sidebar_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sidebar_entry" do
    assert_difference('SidebarEntry.count') do
      post :create, :sidebar_entry => { }
    end

    assert_redirected_to sidebar_entry_path(assigns(:sidebar_entry))
  end

  test "should show sidebar_entry" do
    get :show, :id => sidebar_entries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sidebar_entries(:one).to_param
    assert_response :success
  end

  test "should update sidebar_entry" do
    put :update, :id => sidebar_entries(:one).to_param, :sidebar_entry => { }
    assert_redirected_to sidebar_entry_path(assigns(:sidebar_entry))
  end

  test "should destroy sidebar_entry" do
    assert_difference('SidebarEntry.count', -1) do
      delete :destroy, :id => sidebar_entries(:one).to_param
    end

    assert_redirected_to sidebar_entries_path
  end
end

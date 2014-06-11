require 'test_helper'

class SidebarCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sidebar_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sidebar_category" do
    assert_difference('SidebarCategory.count') do
      post :create, :sidebar_category => { }
    end

    assert_redirected_to sidebar_category_path(assigns(:sidebar_category))
  end

  test "should show sidebar_category" do
    get :show, :id => sidebar_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sidebar_categories(:one).to_param
    assert_response :success
  end

  test "should update sidebar_category" do
    put :update, :id => sidebar_categories(:one).to_param, :sidebar_category => { }
    assert_redirected_to sidebar_category_path(assigns(:sidebar_category))
  end

  test "should destroy sidebar_category" do
    assert_difference('SidebarCategory.count', -1) do
      delete :destroy, :id => sidebar_categories(:one).to_param
    end

    assert_redirected_to sidebar_categories_path
  end
end

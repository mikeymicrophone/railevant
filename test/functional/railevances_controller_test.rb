require File.dirname(__FILE__) + '/../test_helper'
require 'railevances_controller'

# Re-raise errors caught by the controller.
class RailevancesController; def rescue_action(e) raise e end; end

class RailevancesControllerTest < Test::Unit::TestCase
  def setup
    @controller = RailevancesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:railevances)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_railevance
    assert_difference('Railevance.count') do
      post :create, :railevance => { }
    end

    assert_redirected_to railevance_path(assigns(:railevance))
  end

  def test_should_show_railevance
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_railevance
    put :update, :id => 1, :railevance => { }
    assert_redirected_to railevance_path(assigns(:railevance))
  end

  def test_should_destroy_railevance
    assert_difference('Railevance.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to railevances_path
  end
end

require File.dirname(__FILE__) + '/../test_helper'
require 'votes_controller'

# Re-raise errors caught by the controller.
class VotesController; def rescue_action(e) raise e end; end

class VotesControllerTest < Test::Unit::TestCase
  def setup
    @controller = VotesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:votes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_vote
    assert_difference('Vote.count') do
      post :create, :vote => { }
    end

    assert_redirected_to vote_path(assigns(:vote))
  end

  def test_should_show_vote
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_vote
    put :update, :id => 1, :vote => { }
    assert_redirected_to vote_path(assigns(:vote))
  end

  def test_should_destroy_vote
    assert_difference('Vote.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to votes_path
  end
end

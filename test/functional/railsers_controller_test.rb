require File.dirname(__FILE__) + '/../test_helper'
require 'railsers_controller'

# Re-raise errors caught by the controller.
class RailsersController; def rescue_action(e) raise e end; end

class RailsersControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :railsers

  def setup
    @controller = RailsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_allow_signup
    assert_difference 'Railser.count' do
      create_railser
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Railser.count' do
      create_railser(:login => nil)
      assert assigns(:railser).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Railser.count' do
      create_railser(:password => nil)
      assert assigns(:railser).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Railser.count' do
      create_railser(:password_confirmation => nil)
      assert assigns(:railser).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Railser.count' do
      create_railser(:email => nil)
      assert assigns(:railser).errors.on(:email)
      assert_response :success
    end
  end
  
  def test_should_activate_user
    assert_nil Railser.authenticate('aaron', 'test')
    get :activate, :activation_code => railsers(:aaron).activation_code
    assert_redirected_to '/'
    assert_not_nil flash[:notice]
    assert_equal railsers(:aaron), Railser.authenticate('aaron', 'test')
  end 

  protected
    def create_railser(options = {})
      post :create, :railser => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' }.merge(options)
    end
end

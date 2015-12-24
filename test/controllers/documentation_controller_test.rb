require 'test_helper'

class DocumentationControllerTest < ActionController::TestCase
  test "should get install" do
    get :install
    assert_response :success
  end

  test "should get languages" do
    get :languages
    assert_response :success
  end

  test "should get api" do
    get :api
    assert_response :success
  end

end

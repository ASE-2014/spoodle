require 'test_helper'

class EventDatasControllerTest < ActionController::TestCase
  test "should get nw" do
    get :new
    assert_response :success
  end

end

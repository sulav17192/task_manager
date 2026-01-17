require "test_helper"

class Admin::ManagersControllerTest < ActionDispatch::IntegrationTest
  test "should get invite_manager" do
    get admin_managers_invite_manager_url
    assert_response :success
  end
end

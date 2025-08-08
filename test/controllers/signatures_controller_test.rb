require "test_helper"

class SignaturesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get signatures_update_url
    assert_response :success
  end
end

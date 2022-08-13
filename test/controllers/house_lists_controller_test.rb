require "test_helper"

class HouseListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get house_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get house_lists_show_url
    assert_response :success
  end
end

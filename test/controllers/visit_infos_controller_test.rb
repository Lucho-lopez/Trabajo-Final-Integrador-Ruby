require "test_helper"

class VisitInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visit_info = visit_infos(:one)
  end

  test "should get index" do
    get visit_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_visit_info_url
    assert_response :success
  end

  test "should create visit_info" do
    assert_difference("VisitInfo.count") do
      post visit_infos_url, params: { visit_info: { ip_address: @visit_info.ip_address, visited_at: @visit_info.visited_at } }
    end

    assert_redirected_to visit_info_url(VisitInfo.last)
  end

  test "should show visit_info" do
    get visit_info_url(@visit_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_visit_info_url(@visit_info)
    assert_response :success
  end

  test "should update visit_info" do
    patch visit_info_url(@visit_info), params: { visit_info: { ip_address: @visit_info.ip_address, visited_at: @visit_info.visited_at } }
    assert_redirected_to visit_info_url(@visit_info)
  end

  test "should destroy visit_info" do
    assert_difference("VisitInfo.count", -1) do
      delete visit_info_url(@visit_info)
    end

    assert_redirected_to visit_infos_url
  end
end

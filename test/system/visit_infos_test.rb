require "application_system_test_case"

class VisitInfosTest < ApplicationSystemTestCase
  setup do
    @visit_info = visit_infos(:one)
  end

  test "visiting the index" do
    visit visit_infos_url
    assert_selector "h1", text: "Visit infos"
  end

  test "should create visit info" do
    visit visit_infos_url
    click_on "New visit info"

    fill_in "Ip address", with: @visit_info.ip_address
    fill_in "Visited at", with: @visit_info.visited_at
    click_on "Create Visit info"

    assert_text "Visit info was successfully created"
    click_on "Back"
  end

  test "should update Visit info" do
    visit visit_info_url(@visit_info)
    click_on "Edit this visit info", match: :first

    fill_in "Ip address", with: @visit_info.ip_address
    fill_in "Visited at", with: @visit_info.visited_at
    click_on "Update Visit info"

    assert_text "Visit info was successfully updated"
    click_on "Back"
  end

  test "should destroy Visit info" do
    visit visit_info_url(@visit_info)
    click_on "Destroy this visit info", match: :first

    assert_text "Visit info was successfully destroyed"
  end
end

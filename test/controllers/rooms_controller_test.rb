require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get show" do
    room = Room.create!(name: "テスト", address: "東京", price: 1000)
    get room_url(room)
    assert_response :success
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end
end
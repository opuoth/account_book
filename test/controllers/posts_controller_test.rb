require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get outcoming" do
    get posts_outcoming_url
    assert_response :success
  end

  test "should get incoming" do
    get posts_incoming_url
    assert_response :success
  end

  test "should get edit" do
    get posts_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get posts_destroy_url
    assert_response :success
  end

  test "should get update" do
    get posts_update_url
    assert_response :success
  end

end

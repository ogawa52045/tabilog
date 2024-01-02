require "test_helper"

class Piblic::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get piblic_posts_new_url
    assert_response :success
  end

  test "should get index" do
    get piblic_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get piblic_posts_show_url
    assert_response :success
  end

  test "should get edit" do
    get piblic_posts_edit_url
    assert_response :success
  end
end

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should create post" do
    post = Post.create(title: "My title", content: "My content")
    assert post.save
  end

  test "should update post" do
    post = posts(:first_post)
    assert post.update(title: "new title", content: "new content")
  end

  test "should find post" do
    post_id = posts(:first_post).id
    # post = Post.find(post_id)
    # assert_equal post, posts(:first_post),"did not find the record"
    assert_nothing_raised {Post.find(post_id)}
  end

  test "should destroy post" do
    post = posts(:first_post)
    post.destroy
    assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
  end

  test "should not create a post untitled" do
    post = Post.new
    assert post.invalid?, "The post should be invalid"
  end

  test "The title should be unique " do
    post = Post.new
    post.title = posts(:first_post).title
    assert post.invalid?
  end
end

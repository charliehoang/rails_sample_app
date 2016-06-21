require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  test "create should require login" do
    assert_no_difference 'Relationship.count' do
      post :create
    end
    assert_redirected_to login_url
  end 

  test "destroy should require login" do
    assert_no_difference 'Relationship.count' do
      post :destroy, id: relationships(:one)
    end
    assert_redirected_to login_url
  end
end

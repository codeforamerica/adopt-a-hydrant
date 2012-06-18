require 'test_helper'

class SitemapsControllerTest < ActionController::TestCase
  test 'should return an XML sitemap' do
    get :index, format: 'xml'
    assert_response :success
  end
end

require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test 'should return the home page' do
    get :index
    assert_response :success
    assert_select 'title', 'Adopt a Hydrant'
    assert_select 'h1', 'Adopt a Hydrant'
    assert_select 'p#tagline', 'Claim responsibility for shoveling out a fire hydrant after it snows.'
    assert_select 'form' do
      assert_select '[action=?]', '/'
      assert_select '[method=?]', 'post'
    end
    assert_select 'label#city_state_label', 'City'
    assert_select 'select#city_state' do
      assert_select 'option', 'Boston, MA'
    end
    assert_select 'label#address_label', 'Address, Neighborhood'
    assert_select 'input#address', true
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Find hydrants'
    end
    assert_select 'div#map_canvas', true
  end
end

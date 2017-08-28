require 'test_helper'

class InfoWindowControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @thing = things(:thing_1)
    @user = users(:erik)
  end

  test 'should thank the user if the drain is adopted by the user' do
    sign_in @user
    @thing.user_id = @user.id
    @thing.save!
    get :index, thing_id: @thing.id
    assert_not_nil assigns :thing
    assert_response :success
    assert_template 'users/thank_you'
    assert_select 'h2', 'Thank you for adopting this drain!'
    assert_select 'form#abandon_form' do
      assert_select '[action=?]', '/things'
      assert_select '[method=?]', 'post'
    end
    assert_select 'input[name="_method"]' do
      assert_select '[type=?]', 'hidden'
      assert_select '[value=?]', 'put'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Abandon this drain'
    end
  end

  test 'should show the profile if the drain is adopted' do
    @thing.user_id = @user.id
    @thing.save!
    get :index, thing_id: @thing.id
    assert_not_nil assigns :thing
    assert_response :success
    assert_template 'users/profile'
    assert_select 'h4', /This drain has been adopted/
    assert_select 'div', /by #{@user.name}\s+of #{@user.organization}/
  end

  test 'should show adoption form if drain is not adopted' do
    sign_in @user
    get :index, thing_id: @thing.id
    assert_not_nil assigns :thing
    assert_response :success
    assert_template :adopt
    assert_select 'h2', 'Adopt this Drain'
    assert_select 'form#adoption_form' do
      assert_select '[action=?]', '/things'
      assert_select '[method=?]', 'post'
    end
    assert_select 'input[name="_method"]' do
      assert_select '[type=?]', 'hidden'
      assert_select '[value=?]', 'put'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Adopt!'
    end
  end

  test 'should show special link on adoption form if it has one' do
    sign_in @user
    Thing.stub :find_by, @thing do
      @thing.stub :detail_link, 'http://example.com' do
        get :index, thing_id: @thing.id
      end
    end
    assert_response :success
    assert_select 'a', /This .* is special! Learn why./ do
      assert_select '[href=?]', 'http://example.com'
    end
  end

  test 'should show sign-in form if signed out' do
    get :index, thing_id: @thing.id
    assert_not_nil assigns :thing
    assert_response :success
    assert_template 'users/sign_in'
    assert_select 'h3', 'Sign in to adopt this drain'
    assert_select 'a.guidelines p', 'Learn more about adopting a drain'
  end
end

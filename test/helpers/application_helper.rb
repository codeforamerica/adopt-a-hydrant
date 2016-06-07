require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  setup do
    @namespace = 'android-chrome'
    @dimension = 96
    @assets_version = Rails.application.config.assets.version
    @path = "/images/logos/favicons/#{@namespace}-#{dimensions(@dimension)}.png?v=" << @assets_version
    @rel = 'icon'
  end

  test 'should return dimensions' do
    assert_equal('96x96', dimensions(@dimension))
  end

  test "should return a favicon's path" do
    file = 'test.png'
    path = "/images/logos/favicons/#{file}?v=" << @assets_version

    assert_equal(path, favicon_path(file))
  end

  test 'should return favicon attributes' do
    assert_equal({rel: @rel, type: 'image/png'}, favicon_attrs(@rel))
  end

  test 'should return favicon attributes for a given type' do
    rel = 'mask-icon'
    type = 'image/svg+xml'

    assert_equal({rel: rel, type: type}, favicon_attrs(rel, type))
  end

  test "should return a namespaced png favicon's path" do
    assert_equal(@path, namespaced_png_favicon_path(@namespace, @dimension))
  end

  test "should return a namespaced png favicon's link tag" do
    favicon_link_tag = "<link rel=\"#{@rel}\" type=\"image/png\" href=\"" << @path << "\" sizes=\"#{dimensions(@dimension)}\" />"

    assert_equal(favicon_link_tag, namespaced_png_favicon_link_tag(@namespace, @dimension, @rel))
  end
end

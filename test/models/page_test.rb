require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @page = pages(:one)
    @user = users(:one)
  end

  test 'most_common_committer' do
    assert_equal @user, @page.most_common_committer
  end

  test 'Last Updated' do
    assert_equal 'January 01, 2014 00:00', @page.last_updated
  end

  test 'Preview' do
    assert_equal 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.est imperdiet, sed mattis nisl porttitor. Vivamus accumsan vitae urna et pellentesque. Cras fringilla ultricies neque, quis eleifend mauris dignissim quis. Proin posuere diam bibendum elit feugiat cursus. Lorem ipsum dolor sit amet, consecte...', @page.preview
    assert_equal 300, @page.preview.length
  end

end

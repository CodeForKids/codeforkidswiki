require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @page = pages(:one)
    @user = users(:one)
  end

  test 'Latest Committer' do
    assert_equal @user, @page.latest_committer
  end

  test 'Last Updated' do
    assert_equal 'January 01, 2014 00:00', @page.last_updated
  end

  test 'Preview' do
    assert_equal 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.est imperdiet, sed mattis nisl porttitor. Vivamus accumsan vitae urna et pellentesque. Cras fringilla ultricies neque, quis eleifend mauris dignissim quis. Proin posuere diam bibendum elit feugiat cursus. Lorem ipsum dolor sit amet, consecte...', @page.preview
    assert_equal 300, @page.preview.length
  end

  end

# def latest_committer
#   self.commits.first.user
# end

# def last_updated
#   self.updated_at.to_formatted_s(:long)
# end

# def preview
#   ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(self.content).gsub(/&nbsp;/i,""), length: 300)
# end

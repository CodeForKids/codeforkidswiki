class Page  < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :category

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :category

  after_save :add_commit

  private

  def add_commit
    commit = Commit.new
    commit.page = self
    commit.user = User.current_user
    commit.message = 'Commit Message'
    commit.save!
  end

end

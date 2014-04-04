class Page  < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :category
  has_many :commits

  attr_accessor :commit_message

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :category
  validates_presence_of :commit_message

  after_create :create_commit

  def latest_committer
    self.commits.first.user
  end

  private

  def create_commit
    commit = Commit.new
    commit.page = self
    commit.user = User.current_user
    commit.message = 'Initial Commit'
    commit.save!
  end

end

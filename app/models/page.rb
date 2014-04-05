class Page  < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :category
  has_many :commits

  attr_accessor :commit_message

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :category
  validates_presence_of :commit_message

  validates_uniqueness_of :title

  after_create :create_commit
  before_save :change_handle

  def latest_committer
    self.commits.first.user
  end

  def preview
    ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(self.content).gsub(/&nbsp;/i,""), length: 100)
  end

  private

  def change_handle
   self.handle = self.title.parameterize
  end

  def create_commit
    commit = Commit.new
    commit.page = self
    commit.user = User.current_user
    commit.message = 'Initial Commit'
    commit.save!
  end

end

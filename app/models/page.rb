class Page  < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :category
  has_many :commits

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :category

  after_create :create_commit

  attr_accessor :commit

  private

  def create_commit
    commit = Commit.new
    commit.page = self
    commit.user = User.current_user
    commit.message = 'Initial Commit'
    commit.save!
  end

end

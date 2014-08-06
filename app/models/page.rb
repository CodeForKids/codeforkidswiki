class Page  < ActiveRecord::Base
  include ApplicationHelper
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name "wiki-engine-#{Rails.env}"

  mapping do
    indexes :id, index: :not_analyzed
    indexes :title, analyzer: 'snowball', boost: 100
    indexes :content, analyzer: 'snowball'
    indexes :published_at, type: 'date', index: :not_analyzed
    indexes :handle, type: 'string', index: :not_analyzed
    indexes :category_id, type: 'integer', index: :not_analyzed
  end

  def to_indexed_json
    {
      id: id,
      title: title,
      content: content,
      published_at: updated_at,
      handle: handle,
      category_id: category_id
    }.to_json
  end

  belongs_to :category
  counter_culture :category, column_name: :number_of_pages
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
    self.commits.last.user
  end

  def recent_commits(number=5)
    self.commits.last(number).reverse
  end

  def last_updated
    self.updated_at.to_formatted_s(:long)
  end

  def preview
    ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(self.content).gsub(/&nbsp;/i,""), length: 300).html_safe
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

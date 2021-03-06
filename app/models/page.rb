class Page < ActiveRecord::Base
  include ApplicationHelper
  include PgSearch
  pg_search_scope :search,
                  against: [:title, :content],
                  using: { tsearch: { prefix: true, any_word: true } }

  default_scope { where(hidden: false).order('sticky DESC, updated_at DESC') }

  belongs_to :category
  counter_culture :category, column_name: :number_of_pages
  has_many :commits
  has_many :redirects
  acts_as_taggable

  attr_accessor :commit_message

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :category
  validates_presence_of :commit_message

  validates_uniqueness_of :title
  validates :title, length: { minimum: 5, maximum: 50 }

  after_create :create_commit
  before_save :change_handle

  before_destroy :delete_redirects

  def visible_in_search?
    !page.hidden && !page.category.hidden
  end

  def self.most_recent(num)
    unscoped.joins(:category).where(hidden: false).order('updated_at DESC').first(num)
  end

  def most_common_committer
    users_count = commits.group(:user_id).count
    committer_id = users_count.max_by { |_k, v| v }.try(:first)
    if committer_id
      User.find(committer_id)
    else
      User.new(username: 'Unknown', email: 'bob@example.com')
    end
  end

  def recent_commits(number = 5)
    commits.last(number).reverse
  end

  def last_updated
    updated_at.to_formatted_s(:long)
  end

  def preview
    preview = ActionView::Base.full_sanitizer.sanitize(content)
    preview = ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(preview).gsub(/&(.*);/, ''), length: 300).html_safe
  end

  private

  def change_handle
    Redirect.find_or_create_by(from: handle, to: title.parameterize, page_id: id) if make_redirect?
    self.handle = title.parameterize
  end

  def make_redirect?
    !new_record? && title.parameterize != handle
  end

  def create_commit
    commit = Commit.new
    commit.page = self
    commit.user = User.current_user
    commit.message = 'Initial Commit'
    commit.save!
  end

  def delete_redirects
    Redirect.where(page_id: id).delete_all
    true
  end
end

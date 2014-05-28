class Page  < ActiveRecord::Base
  include ApplicationHelper

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

  after_save :enqueue_create_or_update_document_job
  after_destroy :enqueue_delete_document_job

  def latest_committer
    self.commits.first.user
  end

  def last_updated
    self.updated_at.to_formatted_s(:long)
  end

  def preview
    ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(self.content).gsub(/&nbsp;/i,""), length: 300)
  end

  private

  def enqueue_create_or_update_document_job
    if Rails.env.production?
      Delayed::Job.enqueue UpdateSwiftypeJob.new(self.id)
    end
  end

  def enqueue_delete_document_job
    if Rails.env.production?
      Delayed::Job.enqueue DeleteSwiftypeDocumentJob.new(self.id)
    end
  end

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

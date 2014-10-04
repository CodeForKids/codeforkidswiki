class Redirect < ActiveRecord::Base
  validates :from, :to, :page_id, presence: true
  belongs_to :page
end

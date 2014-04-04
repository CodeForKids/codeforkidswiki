class Commit < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  validates_presence_of :message

end

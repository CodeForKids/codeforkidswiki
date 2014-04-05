class Category < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :pages

  before_save :change_handle

  private

  def change_handle
    self.handle = self.name.parameterize
  end

end

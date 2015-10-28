class Category < ActiveRecord::Base
  validates :name, length: {minimum: 5, maximum: 30}, presence: true, uniqueness: true
  has_many :pages

  default_scope { where(hidden: false) }

  before_save :change_handle

  private

  def change_handle
    self.handle = self.name.parameterize
  end

end

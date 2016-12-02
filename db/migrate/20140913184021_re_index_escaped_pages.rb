class ReIndexEscapedPages < ActiveRecord::Migration
  def up
    Page.all.map(&:update_index)
  end
end

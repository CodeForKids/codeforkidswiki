class ReIndexEscapedPages < ActiveRecord::Migration
  def up
    Page.all.map { |page| page.update_index }
  end
end

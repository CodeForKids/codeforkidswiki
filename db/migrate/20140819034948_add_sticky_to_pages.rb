class AddStickyToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sticky, :boolean
  end
end

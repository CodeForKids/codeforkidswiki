class AddHiddenToPagesAndCategories < ActiveRecord::Migration
  def change
    add_column :categories, :hidden, :boolean, index: true, default: false
    add_column :pages, :hidden, :boolean, index: true, default: false
  end
end

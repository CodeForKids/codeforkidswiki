class AddNumberOfPagesToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :number_of_pages, :integer, null: false, default: 0
  end

  def self.down
    remove_column :categories, :number_of_pages
  end
end

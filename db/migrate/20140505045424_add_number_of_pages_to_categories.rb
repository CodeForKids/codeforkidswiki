class AddNumberOfPagesToCategories < ActiveRecord::Migration

  def self.up
    add_column :categories, :number_of_pages, :integer, :null => false, :default => 0

    Category.find_each do |category|
      category.update_attribute(:number_of_pages, category.pages.where(published: true).count)
      category.save
    end
  end

  def self.down
    remove_column :categories, :number_of_pages
  end

end

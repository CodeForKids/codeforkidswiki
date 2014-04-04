class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :admin
      t.binary :image
      t.timestamps
    end

    change_table :pages do |t|
      t.belongs_to :category
    end
  end
end

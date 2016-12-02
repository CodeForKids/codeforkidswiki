class AddFontAwesomeToCategory < ActiveRecord::Migration
  def change
    change_table(:categories) do |t|
      t.string :fontawesome, null: false, default: 'fa-chevron-right'
    end

    remove_column :categories, :image
  end
end

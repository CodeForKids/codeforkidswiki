class AddHandleToCategories < ActiveRecord::Migration
  def change
    change_table(:categories) do |t|
      t.string :handle
    end
  end
end

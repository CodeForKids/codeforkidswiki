class AddHandleToCategories < ActiveRecord::Migration
  def change
    change_table(:categories) do |t|
      t.string :handle
    end

    Category.all.each do |cat|
      cat.handle = cat.name.parameterize
      cat.save(validate: false)
    end

    Page.all.each do |page|
      page.handle = page.title.parameterize
      page.save(validate: false)
    end
  end
end

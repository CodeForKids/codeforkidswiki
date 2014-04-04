class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :handle
      t.boolean :lock
      t.boolean :admin
      t.binary :image
      t.timestamps
    end
  end
end

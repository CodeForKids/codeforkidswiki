class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.belongs_to :page
      t.belongs_to :user
      t.text :message
      t.timestamps
    end
  end
end


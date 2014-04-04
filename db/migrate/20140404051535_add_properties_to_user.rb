class AddPropertiesToUser < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :provider,              :null => false, :default => ""
      t.string :uid,              :null => false, :default => ""
      t.string :username,              :null => false, :default => ""
      t.string :first_name,              :null => false, :default => ""
      t.string :last_name,              :null => false, :default => ""
      t.string :avatar,              :null => false, :default => ""
    end
  end
end

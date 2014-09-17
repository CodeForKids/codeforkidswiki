class CreateRedirectTable < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :from
      t.string :to
    end
  end
end

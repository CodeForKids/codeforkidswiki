class AddPageReferenceToRedirect < ActiveRecord::Migration
  def change
    add_reference :redirects, :page
  end
end

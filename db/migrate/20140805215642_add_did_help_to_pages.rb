class AddDidHelpToPages < ActiveRecord::Migration
  def change
    add_column :pages, :did_help, :integer, default: 0
    add_column :pages, :did_not_help, :integer, default: 0
  end
end

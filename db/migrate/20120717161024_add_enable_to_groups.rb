class AddEnableToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :enable, :boolean
  end
end

class AddStartToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :start, :time
  end
end

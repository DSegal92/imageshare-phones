class AddCounterToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :counter, :integer
  end
end

class AddEndTToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :endT, :time
  end
end

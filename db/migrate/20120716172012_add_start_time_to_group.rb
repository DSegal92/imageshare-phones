class AddStartTimeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :startTime, :integer
  end
end
